import matplotlib.pyplot as plt
import numpy as np
import pandas as pd

blockSize = [32, 64, 128, 256, 512]

missRatesRow64 = {"2k": [3,1,1,0,0],
                  "4k": [3,1,1,0,0],
                  "8k": [3,1,1,0,0],
                  "16k": [3,1,1,0,0],
                  "32k": [3,1,1,0,0]
                  }

missRatesRow128 = {"2k": [3,2,1,0,0],
                  "4k": [3,2,1,0,0],
                  "8k": [3,2,1,0,0],
                  "16k": [3,2,1,0,0],
                  "32k": [3,2,1,0,0]
                  }

missRatesCol64 = {"2k": [91,91,45,33,11],
                  "4k": [91,91,45,33,11],
                  "8k": [91,91,45,33,11],
                  "16k": [3,1,1,0,0],
                  "32k": [3,1,1,0,0]
                  }

missRatesCol128 = {"2k": [98,98,98,49,24],
                   "4k": [98,98,98,49,24],
                   "8k": [98,98,98,49,24],
                   "16k": [98,98,98,49,24],
                   "32k": [98,98,98,49,24]
                   }

plt.plot(blockSize, missRatesRow64["2k"], "o-", label="2k")
plt.plot(blockSize, missRatesRow64["4k"], "o-", label="4k")
plt.plot(blockSize, missRatesRow64["8k"], "o-", label="8k")
plt.plot(blockSize, missRatesRow64["16k"], "o-", label="16k")
plt.plot(blockSize, missRatesRow64["32k"], "o-", label="32k")

plt.title("64 x 64 Row Major Summing")
plt.xlabel("Block Size")
plt.ylabel("Miss Rate (%)")

plt.legend()

plt.show()

plt.plot(blockSize, missRatesRow128["2k"], "o-", label="2k")
plt.plot(blockSize, missRatesRow128["4k"], "o-", label="4k")
plt.plot(blockSize, missRatesRow128["8k"], "o-", label="8k")
plt.plot(blockSize, missRatesRow128["16k"], "o-", label="16k")
plt.plot(blockSize, missRatesRow128["32k"], "o-", label="32k")

plt.title("128 x 128 Row Major Summing")
plt.xlabel("Block Size")
plt.ylabel("Miss Rate (%)")

plt.legend()

plt.show()

plt.plot(blockSize, missRatesCol64["2k"], "o-", label="2k")
plt.plot(blockSize, missRatesCol64["4k"], "o-", label="4k")
plt.plot(blockSize, missRatesCol64["8k"], "o-", label="8k")
plt.plot(blockSize, missRatesCol64["16k"], "o-", label="16k")
plt.plot(blockSize, missRatesCol64["32k"], "o-", label="32k")

plt.title("64 x 64 Column Major Summing")
plt.xlabel("Block Size")
plt.ylabel("Miss Rate (%)")

plt.legend()

plt.show()

plt.plot(blockSize, missRatesCol128["2k"], "o-", label="2k")
plt.plot(blockSize, missRatesCol128["4k"], "o-", label="4k")
plt.plot(blockSize, missRatesCol128["8k"], "o-", label="8k")
plt.plot(blockSize, missRatesCol128["16k"], "o-", label="16k")
plt.plot(blockSize, missRatesCol128["32k"], "o-", label="32k")

plt.title("128 x 128 Column Major Summing")
plt.xlabel("Block Size")
plt.ylabel("Miss Rate (%)")

plt.legend()

plt.show()

