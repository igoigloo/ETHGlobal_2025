Welcome to Dynamic 🙌
You can install the Dynamic SDK in 3 quick steps!

Install the Dynamic SDK

yarn add viem @dynamic-labs/sdk-react-core @dynamic-labs/ethereum

Copy the snippet into your project

```
import {
  DynamicContextProvider,
  DynamicWidget,
} from "@dynamic-labs/sdk-react-core";

import { EthereumWalletConnectors } from "@dynamic-labs/ethereum";


export default function App() {
  return (
    <DynamicContextProvider
      settings={{
        environmentId: "8a9f9297-6297-461f-acf8-4611cb91158d",
        walletConnectors: [EthereumWalletConnectors],
      }}
    >
      <DynamicWidget />
    </DynamicContextProvider>
  );

```


We are using your Sandbox environment ID which you can find here.

