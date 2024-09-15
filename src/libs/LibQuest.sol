// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "../shared/Structs.sol";
import "./LibQuestStorage.sol";

library LibQuest {

    /// @notice Internal function to access NFT Building storage
    /// @return data The LibLandBuildingStorage.Data struct
    function _sQ() internal pure returns (LibQuestStorage.Data storage data) {
        data = LibQuestStorage.data();
    }

    // Constants //TODO: Move to LibConstants
    //uint256  constant BLOCK_TIME = 2; // Block time in seconds (assumed)
    //uint256  constant MAX_LEVEL = 3;  // Max farmer level
    uint256  constant MAX_FARMER_SLOTS = 3; // Max farmer slots per land
    //uint256  constant PLANT_POINT_DECIMALS = 12;
    //uint256  constant XP_DECIMALS = 1 ether; // 1e18


    // // Enums
    // enum QuestDifficultyLevel {EASY, MEDIUM, HARD}
    // enum RewardType {SEED, LEAF, PLANT_LIFE_TIME, PLANT_POINTS, XP}

    // // Structs
    // struct QuestDifficulty {
    //     QuestDifficultyLevel difficulty;
    //     uint256 durationInBlocks;
    //     uint256 cooldownInBlocks;
    //     uint256 rewardMultiplier;
    // }

    // struct Quest {
    //     QuestDifficultyLevel difficulty;
    //     uint256 startBlock;
    //     uint256 endBlock;
    //     uint256 blockHeightPseudoRnd;
    //     bool completed;
    //     bool exists;
    //     RewardType rewardType;
    //     uint256 rewardAmount;
    // }

    // // Mappings
    // mapping(QuestDifficultyLevel => QuestDifficulty) public questDifficulties;
    // mapping(uint256 => mapping(uint256 => Quest)) public landQuests; // landId => farmerSlotId => Quest

    // Reward ranges
    uint256  constant MIN_SEED_REWARD = 10 ether;
    uint256  constant MAX_SEED_REWARD = 100 ether;

    uint256  constant MIN_LEAF_REWARD = 10 ether * 3285; //3285 = 69 billion / 21 million
    uint256  constant MAX_LEAF_REWARD = 100 ether * 3285; //3285 = 69 billion / 21 million

    uint256  constant MIN_PLANT_LIFE_TIME_REWARD = 1 hours;
    uint256  constant MAX_PLANT_LIFE_TIME_REWARD = 12 hours;

    uint256  constant MIN_PLANT_POINTS_REWARD = 10 * 10 ** LibConstants.PLANT_POINT_DECIMALS;
    uint256  constant MAX_PLANT_POINTS_REWARD = 100 * 10 ** LibConstants.PLANT_POINT_DECIMALS;

    uint256  constant MIN_XP_REWARD = 1 * 10 ** LibConstants.XP_DECIMALS;
    uint256  constant MAX_XP_REWARD = 5 * 10 ** LibConstants.XP_DECIMALS;

    // Events
    //
    event QuestStarted(
        uint256 indexed landId,
        uint256 indexed farmerSlotId,
        //address indexed player,
        QuestDifficultyLevel difficulty,
        uint256 startBlock,
        uint256 endBlock
    );

    event QuestCommitted(
        uint256 indexed landId,
        uint256 indexed farmerSlotId,
        //address indexed player,
        uint256 blockHeightPseudoRnd
    );

    event QuestFinalized(
        uint256 indexed landId,
        uint256 indexed farmerSlotId,
        address indexed player,
        RewardType rewardType,
        uint256 amount
    );

    event QuestReset(
        uint256 indexed landId,
        uint256 indexed farmerSlotId,
        address indexed player
    );



    // function hoursToBlocks(uint256 _hours) internal pure returns (uint256) {
    //     return (_hours * 3600) / BLOCK_TIME;
    // }


// Transaction 1: Send farmer to a quest
    function startQuest(
        uint256 landId,
        QuestDifficultyLevel difficultyLevel,
        uint256 farmerSlotId
    ) public {
        require(farmerSlotId < MAX_FARMER_SLOTS, "Invalid farmer slot");

        Quest storage quest = _sQ().landQuests[landId][farmerSlotId];
        require(
            !quest.exists || quest.completed,
            "Previous quest not completed"
        );
        // require(
        //     !quest.exists,
        //     "Quest already in progress"
        // );

        QuestDifficulty storage difficulty = _sQ().questDifficulties[difficultyLevel];

        quest.difficulty = difficultyLevel;
        quest.startBlock = block.number;
        quest.endBlock = block.number + difficulty.durationInBlocks;
        quest.blockHeightPseudoRnd = 0;
        quest.completed = false;
        quest.exists = true;
        quest.rewardType = RewardType.SEED; // Default value, will be set later
        quest.rewardAmount = 0;

        emit QuestStarted(
            landId,
            farmerSlotId,
            difficultyLevel,
            quest.startBlock,
            quest.endBlock
        );
    }

    // Transaction 2: Commit quest (after quest duration has passed)
    function commitQuest(uint256 landId, uint256 farmerSlotId) public {
        Quest storage quest = _sQ().landQuests[landId][farmerSlotId];

        require(quest.exists, "No quest found");
        require(quest.endBlock <= block.number, "Quest not yet ended");
        require(quest.blockHeightPseudoRnd == 0, "Quest already committed");

        // Assign blockHeightPseudoRnd as current block number + 1
        quest.blockHeightPseudoRnd = block.number + 1;

        emit QuestCommitted(
            landId,
            farmerSlotId,
            quest.blockHeightPseudoRnd
        );
    }

// Transaction 3: Finalize quest and assign rewards
    function finalizeQuest(uint256 landId, uint256 farmerSlotId)  public returns (bool success) {
       
        //uint256 landId = playerLandIds[msg.sender];
        //require(landId != 0, "Player has no land assigned");
        Quest storage quest = _sQ().landQuests[landId][farmerSlotId];

        require(quest.exists, "No quest found");
        require(
            quest.blockHeightPseudoRnd != 0,
            "Quest has not been committed"
        );
        if (block.number > quest.blockHeightPseudoRnd + 256) {
        // Too late to finalize, reset the quest
            resetQuest(landId, farmerSlotId);
            emit QuestReset(landId, farmerSlotId, msg.sender);
            return false;
        
        }
        require(
            block.number >= quest.blockHeightPseudoRnd,
            "Too early to finalize"
        );
        require(!quest.completed, "Quest already finalized");

        // Get a pseudo-random number using the block hash
        bytes32 randomHash = blockhash(quest.blockHeightPseudoRnd);
        uint256 randomNumber = uint256(randomHash);

        // Use the random number to assign a single reward
        (RewardType rewardType, uint256 rewardAmount) = assignRewards(randomNumber, quest.difficulty);

        // Record the reward in the quest struct
        quest.rewardType = rewardType;
        quest.rewardAmount = rewardAmount;

        // Mark quest as completed
        quest.completed = true;

        emit QuestFinalized(
            landId,
            farmerSlotId,
            msg.sender,
            rewardType,
            rewardAmount
        );
        return true;
    }

        // Assign a single reward based on random number and difficulty
    function assignRewards(
        uint256 randomNumber,
        QuestDifficultyLevel difficultyLevel
    ) internal returns (RewardType, uint256) {
        // Randomly select one reward type
        uint256 rewardIndex = randomNumber % 5; // There are 5 reward types
        RewardType rewardType = RewardType(rewardIndex);

        uint256 rewardAmount;
        uint256 minReward;
        uint256 maxReward;

        // Determine min and max reward based on reward type
        if (rewardType == RewardType.SEED) {
            minReward = MIN_SEED_REWARD;
            maxReward = MAX_SEED_REWARD;
        } else if (rewardType == RewardType.LEAF) {
            minReward = MIN_LEAF_REWARD;
            maxReward = MAX_LEAF_REWARD;
        } else if (rewardType == RewardType.PLANT_LIFE_TIME) {
            minReward = MIN_PLANT_LIFE_TIME_REWARD;
            maxReward = MAX_PLANT_LIFE_TIME_REWARD;
        } else if (rewardType == RewardType.PLANT_POINTS) {
            minReward = MIN_PLANT_POINTS_REWARD;
            maxReward = MAX_PLANT_POINTS_REWARD;
        } else if (rewardType == RewardType.XP) {
            minReward = MIN_XP_REWARD;
            maxReward = MAX_XP_REWARD;
        }

        // Calculate reward amount
        uint256 rewardRange = maxReward - minReward + 1;
        rewardAmount = (randomNumber % rewardRange) + minReward;
        rewardAmount *= _sQ().questDifficulties[difficultyLevel].rewardMultiplier;

    // Assign the reward (call dummy functions)
        if (rewardType == RewardType.SEED) {
            _assignSeedReward(rewardAmount);
        } else if (rewardType == RewardType.LEAF) {
            _assignLeafReward(rewardAmount);
        } else if (rewardType == RewardType.PLANT_LIFE_TIME) {
            _assignPlantLifeTimeReward(rewardAmount);
        } else if (rewardType == RewardType.PLANT_POINTS) {
            _assignPlantPointsReward(rewardAmount);
        } else if (rewardType == RewardType.XP) {
            _assignXpReward(rewardAmount);
        }

        return (rewardType, rewardAmount);
    }

    // Dummy reward assignment functions
    function _assignSeedReward(uint256 amount) internal {
    // Implement ERC20 transfer logic or any other logic
    }

    function _assignLeafReward(uint256 amount) internal {
    // Implement ERC20 transfer logic or any other logic
    }

    function _assignPlantLifeTimeReward(uint256 amount) internal {
    // Implement logic to increase plant lifetime
    }

    function _assignPlantPointsReward(uint256 amount) internal {
    // Implement logic to add plant points
    }

    function _assignXpReward(uint256 amount) internal {
    // Implement logic to add experience points
    }

    // Reset quest
    function resetQuest(uint256 landId, uint256 farmerSlotId) internal {
        delete _sQ().landQuests[landId][farmerSlotId];
    }

    // Get quest details for a specific landId and farmerSlotId
    function getQuest(uint256 landId, uint256 farmerSlotId) public view returns (Quest memory) {
        return _sQ().landQuests[landId][farmerSlotId];
    }

    // Get all quests for a landId
    function getQuests(uint256 landId) public view returns (Quest[] memory) {
        Quest[] memory quests = new Quest[](MAX_FARMER_SLOTS);
        for (uint256 i = 0; i < MAX_FARMER_SLOTS; i++) {
            quests[i] = _sQ().landQuests[landId][i];
        }
        return quests;
    }
}
