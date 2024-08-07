// @ts-check

import abi from './src/generated/abi.json' assert { type: 'json' };
import {actions} from "@wagmi/cli/plugins";

/** @type {import('@wagmi/cli').Config} */
export default {
  out: 'scripts/generated_land_wagmi.mjs',
  contracts: [{ name: 'Land', abi: abi, address: {
          84532: '0xc7EdFFa05A3D65F340048E28d5DA06CFf1EB2Eba'
      }  }],
  plugins: [
      actions()
  ],
}

