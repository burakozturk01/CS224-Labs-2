import matplotlib.pyplot as plt
import numpy as np
import pandas as pd

sizeCount = ["16384/512", "2048/128", "2048/32"]

hitRates = {"Direct": [100,55,9],
             "FullLRU": [100,55,9],
             "FullRandom": [100,55,11]}

hitRates2 = {"Direct": [76,51,2],
              "FullLRU": [76,51,2],
              "FullRandom": [76,51,2]}

plt.plot(sizeCount, hitRates["Direct"], "o-", label="Direct Mapped")
plt.plot(sizeCount, hitRates["FullLRU"], "o-", label="Fully Associated / LRU")
plt.plot(sizeCount, hitRates["FullRandom"], "o-", label="Fully Associated / Random")

plt.title("Cache Types")
plt.xlabel("Cache Size / Blocks")
plt.ylabel("Hit Rate (%)")

plt.legend()

plt.show()

plt.plot(sizeCount, hitRates2["Direct"], "o-", label="Direct Mapped")
plt.plot(sizeCount, hitRates2["FullLRU"], "o-", label="Fully Associated / LRU")
plt.plot(sizeCount, hitRates2["FullRandom"], "o-", label="Fully Associated / Random")

plt.title("Cache Types")
plt.xlabel("Cache Size / Blocks")
plt.ylabel("Hit Rate (%)")

plt.legend()

plt.show()
