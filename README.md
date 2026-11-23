# Seat racing with eight rowers: a six-race design that uses what you already know

You have eight rowers, four on stroke side and four on bow side, two coxless fours and a limited amount of time on the water. You want a ranking within each side that you can defend to the athletes. This post describes a six-race schedule that does that with nothing more than a stopwatch and addition, and explains how big a difference in time has to be before you can say it is real and not noise.

**The short version**

- Six races is the minimum, and every one of the six races involves all eight rowers.
- The ranking is the total time of the six boats each rower raced in; the lowest total on each side wins.
- With 200 s races over 800 m, a gap of about **4.4 s** in total time between two rowers on the same side is roughly the point where you can be 95% sure the order is right. Gaps under about **3.4 s** are within chance. In terms of power, that is a difference of roughly 6–7%.
- The schedule uses your prior ranking of the rowers to keep races reasonably even, so no race is expected to be a procession.
- Two things matter more than the design itself: how accurately you time the boats, and whether the two shells (or lanes) are equally fast. Part 1 covers the first, Part 2 the second.

Part 1 is for coaches who want to run the design. Part 2 is for those who want to check the reasoning.

---

# Part 1: The design and how to use it

## The setup

There are eight rowers: **SS1–SS4** on stroke side and **BS1–BS4** on bow side. The number is the *assumed prior power rank* on that side, from erg tests or your own judgement: 1 is the strongest, 4 the weakest. Two coxless fours race each other, each boat with two stroke-side and two bow-side rowers. Boat 1 is the same shell and lane in every race. The aim is a ranking within each side.

## The schedule

| Race | Boat 1 | Boat 2 |
|---|---|---|
| R1 | SS1, SS2, BS1, BS4 | SS3, SS4, BS2, BS3 |
| R2 | SS1, SS2, BS2, BS3 | SS3, SS4, BS1, BS4 |
| R3 | SS1, SS3, BS1, BS3 | SS2, SS4, BS2, BS4 |
| R4 | SS1, SS3, BS2, BS4 | SS2, SS4, BS1, BS3 |
| R5 | SS1, SS4, BS1, BS2 | SS2, SS3, BS3, BS4 |
| R6 | SS2, SS3, BS1, BS2 | SS1, SS4, BS3, BS4 |

The order of the races can be shuffled freely. The pairings cannot be changed without losing the properties below.

## Why this design

**It is the minimum number of races.** On each side there are only three differences to find (rank 1 against 2, 2 against 3, and 3 against 4), so six differences in all. Each race gives one margin, so you cannot do it in fewer than six, and six is enough.

**It is strongly symmetric.** Every rower races in all six races. The table shows in how many of the six races two rowers are in the *same* boat.

| | SS1 | SS2 | SS3 | SS4 | BS1 | BS2 | BS3 | BS4 |
|---|---|---|---|---|---|---|---|---|
| **SS1** | 6 | 2 | 2 | 2 | 3 | 3 | 3 | 3 |
| **SS2** | 2 | 6 | 2 | 2 | 3 | 3 | 3 | 3 |
| **SS3** | 2 | 2 | 6 | 2 | 3 | 3 | 3 | 3 |
| **SS4** | 2 | 2 | 2 | 6 | 3 | 3 | 3 | 3 |
| **BS1** | 3 | 3 | 3 | 3 | 6 | 2 | 2 | 2 |
| **BS2** | 3 | 3 | 3 | 3 | 2 | 6 | 2 | 2 |
| **BS3** | 3 | 3 | 3 | 3 | 2 | 2 | 6 | 2 |
| **BS4** | 3 | 3 | 3 | 3 | 2 | 2 | 2 | 6 |

Any two rowers on the same side are in the same boat twice and against each other four times. Any stroke-side and bow-side pair are together three times and against each other three times. No rower is favoured by who they row with.

**The ranking is just addition.** For each rower, add up the times of the six boats they rowed in. On each side, the rower with the lowest total is the best. The difference between two rowers' totals is also the thing you test for significance (below). You do not need a spreadsheet, and the result is exactly what a least-squares analysis of this design would give.

**Everyone races the same number of times, in the same format.** Every rower races six times against the same kind of opposition on the same course. This is a fair test only if the conditions are the same for everyone, and one condition is not perfectly even: the split between the two shells (Part 2).

**It is transparent.** The whole schedule is fixed in advance, so athletes know who will race whom before the first race. Nothing is decided after seeing results, so nobody can suspect a selection.

**Every race counts for everyone.** All eight rowers are in every race and every result goes into the totals. Nobody sits out and no race is a throwaway.

**It uses what you already know.** Because the rowers are ranked in advance, you can predict how close each race will be. The schedule is chosen so that no race is expected to be lopsided. The expected margin is at most 4 rank steps of prior power (a rank step being the power gap between adjacent ranks), and one race, R4, is expected to be dead even. Other arrangements of the same rowers have races expected to be 6 or 8 rank steps apart (Part 2).

## A worked example

These are synthetic times (about 200 s for 800 m), made up with noise to show how the method works. They are not real data.

| Race | Boat 1 | Time (s) | Boat 2 | Time (s) | Margin (s) |
|---|---|---|---|---|---|
| R1 | SS1, SS2, BS1, BS4 | 194.3 | SS3, SS4, BS2, BS3 | 197.1 | 2.8 |
| R2 | SS1, SS2, BS2, BS3 | 195.1 | SS3, SS4, BS1, BS4 | 196.2 | 1.1 |
| R3 | SS1, SS3, BS1, BS3 | 192.6 | SS2, SS4, BS2, BS4 | 196.5 | 3.9 |
| R4 | SS1, SS3, BS2, BS4 | 196.4 | SS2, SS4, BS1, BS3 | 198.3 | 1.9 |
| R5 | SS1, SS4, BS1, BS2 | 192.6 | SS2, SS3, BS3, BS4 | 199.8 | 7.2 |
| R6 | SS2, SS3, BS1, BS2 | 193.7 | SS1, SS4, BS3, BS4 | 197.8 | 4.1 |

Adding up the six boat times for each rower, for example SS1: 194.3 + 195.1 + 192.6 + 196.4 + 192.6 + 197.8 = 1168.8 s.

| Stroke side | Total (s) | Behind best (s) | Bow side | Total (s) | Behind best (s) |
|---|---|---|---|---|---|
| SS1 | 1168.8 | 0.0 | BS1 | 1167.7 | 0.0 |
| SS3 | 1175.8 | 7.0 | BS2 | 1171.4 | 3.7 |
| SS2 | 1177.7 | 8.9 | BS3 | 1180.7 | 13.0 |
| SS4 | 1178.5 | 9.7 | BS4 | 1181.0 | 13.3 |

Reading it with the thresholds below (about 5.3 s for a clear difference, under 3.4 s inconclusive):

- On stroke side SS1 is clearly ahead of the other three. SS2, SS3 and SS4 are within 2.7 s of each other, so **they cannot be separated**. The raw ranking has SS3 above SS2, and the prior ranking put SS2 above SS3. The data does not overrule the prior.
- On bow side BS1 and BS2 are clearly ahead of BS3 and BS4, and BS3 and BS4 are 0.3 s apart, which is a tie. BS1 is 3.7 s ahead of BS2, which makes it probable but not conclusive that BS1 is stronger.

This is typical. Six races separate groups well and neighbours poorly. Tell the athletes that "tied within the noise" is a legitimate outcome.

## When is a difference real? (200 s, 800 m)

The difference between two rowers' totals is the number to judge. Positive means the first rower's boats were faster in total over the six races. The noise comes from three places, and I have assumed values for each:

- the rowers: each rower's power varies by about 1.5% from race to race, including fatigue that affects some rowers more than others;
- the conditions: wind, stream and lane move each boat by about 0.4 s;
- the timing: reading each boat's time has an error of about 0.7 s.

With those, one race margin has a standard deviation of about 1.34 s, and the smallest difference in total time you can trust is:

| Chance that the observed order is right | Difference in total time over the six races | Average per race | Rower power difference (rough) |
|---|---|---|---|
| 90% | 3.4 s | 0.9 s | 5.2% |
| 95% | 4.4 s | 1.1 s | 6.6% |
| 97.5% (the usual two-sided 95% test) | 5.3 s | 1.3 s | 7.9% |
| 99% | 6.2 s | 1.6 s | 9.4% |

The power difference is the gap in power between two rowers that would show up as that time difference. One rower is a quarter of a four, and boat time changes roughly as power to the power $-1/3$, so about 1 s gained over 200 s corresponds to a rower power difference of about 6%.

Put the other way round, for two adjacent rowers whose true difference in effect is:

| True difference | Chance they are ranked in the right order |
|---|---|
| 0.25 s (1.5% power) | 65% |
| 0.5 s (3%) | 77% |
| 0.75 s (4.5%) | 87% |
| 1.0 s (6%) | 93% |
| 1.5 s (9%) | 99% |

If the three adjacent steps on a side are all 0.5 s, the chance of getting all four rowers in the right order is only about 37%. At 1.0 s per step it is 74%, at 1.5 s 91% and at 2.0 s 98%. In plain terms, **six races at this noise level can rank rowers who are 8–10% apart in power, but not rowers who are 3% apart.**

These noise values are assumptions, not measurements. The thresholds scale in proportion to the noise: half the noise, half the threshold. About half of the variance in a margin comes from the timing error alone, which makes timing the cheapest thing to improve.

## Practical advice

- **Time the boats carefully.** Use the same finish line and the same method for both boats in every race, ideally electronic or video timing. If the timing error fell from 0.7 s to 0.1 s per boat, the 95% threshold would drop from 4.4 s to about 3.0 s.
- **Keep the conditions the same.** Same shells and lanes for Boat 1 and Boat 2 in every race, same start procedure and rate guidance, equal rest between races.
- **Do not read single races.** One race margin has noise of about 1.3 s on its own, which is as big as many real differences. Use the totals.
- **Fatigue that hits everyone equally is not a problem.** If everyone slows by the same amount, both boats slow equally and the margin barely changes. Differences in how much individual rowers fade are noise that is already allowed for.
- **Treat gaps under about 3.4 s in total as ties** and use the prior ranking, or extra races, to separate them. Rowing the whole schedule twice (12 races) cuts the thresholds by about 30%.
- **Check the shells.** If one shell or lane is faster, the unequal split described in Part 2 can add several seconds of bias to the totals. A seventh race, R4 again with the crews swapped between the shells, fixes this at no cost in accuracy.

---

# Part 2: Under the hood

## The model, written out

Give every rower a number: $x_{\mathrm{SS1}}, x_{\mathrm{SS2}}, \ldots, x_{\mathrm{BS4}}$. It is the number of seconds that rower is worth over the race distance. If you replace rower $j$ by rower $i$ in the same seat, the four finishes $x_i - x_j$ seconds sooner. These eight numbers are what we want to rank.

What we observe are the six margins $d_1, \ldots, d_6$, where $d_r = t_2 - t_1$ is the time of Boat 2 minus the time of Boat 1 in race $r$. It is positive when Boat 1 is faster. The model says that each margin is the total worth of the rowers in Boat 1 minus the total worth of the rowers in Boat 2, plus noise $\varepsilon_r$. For the six races of the schedule that is

$$
\begin{aligned}
d_1 &= (x_{\mathrm{SS1}} + x_{\mathrm{SS2}} + x_{\mathrm{BS1}} + x_{\mathrm{BS4}}) - (x_{\mathrm{SS3}} + x_{\mathrm{SS4}} + x_{\mathrm{BS2}} + x_{\mathrm{BS3}}) + \varepsilon_1 \\
d_2 &= (x_{\mathrm{SS1}} + x_{\mathrm{SS2}} + x_{\mathrm{BS2}} + x_{\mathrm{BS3}}) - (x_{\mathrm{SS3}} + x_{\mathrm{SS4}} + x_{\mathrm{BS1}} + x_{\mathrm{BS4}}) + \varepsilon_2 \\
d_3 &= (x_{\mathrm{SS1}} + x_{\mathrm{SS3}} + x_{\mathrm{BS1}} + x_{\mathrm{BS3}}) - (x_{\mathrm{SS2}} + x_{\mathrm{SS4}} + x_{\mathrm{BS2}} + x_{\mathrm{BS4}}) + \varepsilon_3 \\
d_4 &= (x_{\mathrm{SS1}} + x_{\mathrm{SS3}} + x_{\mathrm{BS2}} + x_{\mathrm{BS4}}) - (x_{\mathrm{SS2}} + x_{\mathrm{SS4}} + x_{\mathrm{BS1}} + x_{\mathrm{BS3}}) + \varepsilon_4 \\
d_5 &= (x_{\mathrm{SS1}} + x_{\mathrm{SS4}} + x_{\mathrm{BS1}} + x_{\mathrm{BS2}}) - (x_{\mathrm{SS2}} + x_{\mathrm{SS3}} + x_{\mathrm{BS3}} + x_{\mathrm{BS4}}) + \varepsilon_5 \\
d_6 &= (x_{\mathrm{SS2}} + x_{\mathrm{SS3}} + x_{\mathrm{BS1}} + x_{\mathrm{BS2}}) - (x_{\mathrm{SS1}} + x_{\mathrm{SS4}} + x_{\mathrm{BS3}} + x_{\mathrm{BS4}}) + \varepsilon_6
\end{aligned}
$$

Each equation is one line of the schedule. It is tidier to record who is in which boat as a table of $+1$ (Boat 1) and $-1$ (Boat 2). Call this table $S$:

| | SS1 | SS2 | SS3 | SS4 | BS1 | BS2 | BS3 | BS4 |
|---|---|---|---|---|---|---|---|---|
| R1 | +1 | +1 | −1 | −1 | +1 | −1 | −1 | +1 |
| R2 | +1 | +1 | −1 | −1 | −1 | +1 | +1 | −1 |
| R3 | +1 | −1 | +1 | −1 | +1 | −1 | +1 | −1 |
| R4 | +1 | −1 | +1 | −1 | −1 | +1 | −1 | +1 |
| R5 | +1 | −1 | −1 | +1 | +1 | +1 | −1 | −1 |
| R6 | −1 | +1 | +1 | −1 | +1 | +1 | −1 | −1 |

Multiplying each row of $S$ by the list of the $x$ values and adding up gives exactly the right-hand sides above. Writing the six equations at once:

$$
\underbrace{\begin{pmatrix} d_1 \\ d_2 \\ d_3 \\ d_4 \\ d_5 \\ d_6 \end{pmatrix}}_{d\ \text{(margins)}}
=
\underbrace{\begin{pmatrix}
+1 & +1 & -1 & -1 & +1 & -1 & -1 & +1 \\
+1 & +1 & -1 & -1 & -1 & +1 & +1 & -1 \\
+1 & -1 & +1 & -1 & +1 & -1 & +1 & -1 \\
+1 & -1 & +1 & -1 & -1 & +1 & -1 & +1 \\
+1 & -1 & -1 & +1 & +1 & +1 & -1 & -1 \\
-1 & +1 & +1 & -1 & +1 & +1 & -1 & -1
\end{pmatrix}}_{S}
\underbrace{\begin{pmatrix} x_{\mathrm{SS1}} \\ x_{\mathrm{SS2}} \\ x_{\mathrm{SS3}} \\ x_{\mathrm{SS4}} \\ x_{\mathrm{BS1}} \\ x_{\mathrm{BS2}} \\ x_{\mathrm{BS3}} \\ x_{\mathrm{BS4}} \end{pmatrix}}_{x}
+
\underbrace{\begin{pmatrix} \varepsilon_1 \\ \varepsilon_2 \\ \varepsilon_3 \\ \varepsilon_4 \\ \varepsilon_5 \\ \varepsilon_6 \end{pmatrix}}_{\varepsilon\ \text{(noise)}},
\qquad\text{or}\qquad d = S x + \varepsilon .
$$

Reading $S$ across a row tells you who races whom in that race. Reading it down a column tells you how a rower's six races went: how often in Boat 1 and how often in Boat 2.

Two things to notice:

- **Only differences within a side can be found.** Add the same number to all four stroke-side $x$ values and every margin stays the same, because each boat has two stroke-side rowers. The same holds for bow side. That is all a ranking needs, but it means there are only three unknowns per side (rank 1 against 2, 2 against 3, 3 against 4), six in total.
- **Six equations for six unknowns.** The design is exactly determined, which is why six is the minimum. It also means there is no spare race to estimate the noise from the data itself.

## Where the schedule comes from

On each side there are only three ways to split four rowers into two pairs. With ranks 1 (strongest) to 4:

- **A**: {1,2} against {3,4}, the strong pair against the weak pair;
- **B**: {1,3} against {2,4};
- **C**: {1,4} against {2,3}.

If one rank step of prior power is worth $\delta$ seconds, the expected margin from one side is $4\delta$ for A, $2\delta$ for B and $0$ for C. The margin of a race is the stroke-side contribution plus or minus the bow-side contribution, and you choose which boat gets which pair. The recommended schedule combines them as stroke/bow splits A/C, A/C, B/B, B/B, C/A, C/A, with the bow side's sign reversed in the second race of each pair.

Split A is the only one that links the strong pair to the weak pair, so it cannot be dropped: without it, the gap between ranks 2 and 3 is not measurable. That is why one uneven race per pair is unavoidable.

## Why the ranking is just total time

For two rowers $i$ and $j$, count the races in which they are in the same boat and subtract the number in which they are in opposite boats. Arranged as a table, this is exactly the symmetry table from Part 1 with $+1$ and $-1$ weights:

$$
S^\top S = \begin{pmatrix}
6 & -2 & -2 & -2 & 0 & 0 & 0 & 0 \\
-2 & 6 & -2 & -2 & 0 & 0 & 0 & 0 \\
-2 & -2 & 6 & -2 & 0 & 0 & 0 & 0 \\
-2 & -2 & -2 & 6 & 0 & 0 & 0 & 0 \\
0 & 0 & 0 & 0 & 6 & -2 & -2 & -2 \\
0 & 0 & 0 & 0 & -2 & 6 & -2 & -2 \\
0 & 0 & 0 & 0 & -2 & -2 & 6 & -2 \\
0 & 0 & 0 & 0 & -2 & -2 & -2 & 6
\end{pmatrix}
$$

($S^\top S$ is simply the name for this table.) Two rowers on the same side are together twice and against four times, so the entry is $2 - 4 = -2$. A stroke-side and a bow-side rower are together three times and against three times: $3 - 3 = 0$. Each rower is with themselves in all six races: $6$. Because of this symmetry the least-squares answer is as simple as it can be:

$$
\hat{x}_i = \frac{1}{8}\sum_{r=1}^{6} S_{ri}\, d_r = \frac{C - 2\,T_i}{8},
$$

where $T_i$ is the sum of the times of the six boats rower $i$ rowed in, and $C$ is the sum of all twelve boat times, the same for everybody. So ranking by $\hat{x}_i$ is ranking by $T_i$, smallest first. The difference between two rowers is

$$
T_j - T_i = 4\,(\hat{x}_i - \hat{x}_j),
$$

and only the four races in which they are in opposite boats contribute to it, because in the other two their boats' times are identical. The partners and the other side cancel in expectation, so comparing raw totals is unbiased. Each margin has noise $\sigma$ and the four are independent, so

$$
\mathrm{SE}(T_j - T_i) = 2\sigma, \qquad \mathrm{SE}(\hat{x}_i - \hat{x}_j) = \sigma/2 .
$$

This is the smallest standard error any design built from these splits can reach, and every pair of rowers on a side gets exactly this precision.

## Who races how often in each shell

The weak spot is how often each rower is in Boat 1 and Boat 2. This is the column count of $S$.

| Rower | Races in Boat 1 | Races in Boat 2 | Score shift per second of Boat 1 advantage |
|---|---|---|---|
| SS1 | 5 | 1 | +0.50 |
| SS2 | 3 | 3 | 0 |
| SS3 | 3 | 3 | 0 |
| SS4 | 1 | 5 | −0.50 |
| BS1 | 4 | 2 | +0.25 |
| BS2 | 4 | 2 | +0.25 |
| BS3 | 2 | 4 | −0.25 |
| BS4 | 2 | 4 | −0.25 |

If Boat 1 (a particular shell or lane) is faster by $c$ seconds, each margin is shifted by $c$ and a rower's score by $c\,(n_{1} - n_{2})/8$. A 1 s advantage for Boat 1 therefore makes SS1 look 1 s per race better than SS4 for no reason, which is **4 s in the totals**, about as much as the 4.4 s detection threshold.

This cannot be removed by relabelling the boats. The six races give six independent equations, so no choice of which boat is called "Boat 1" can make every count equal. The total squared shift is fixed, and the matrix above has relabelled R6 so that the largest shift between adjacent ranks is $0.5c$, not $c$. There are two remedies:

1. **A seventh race**: R4 again with the crews' shells swapped, called R7. R4 was expected to be dead even, so the two margins estimate the shell effect directly: $\hat c = (d_4 + d_7)/2$. The scores become $\hat{x}_i = \frac{1}{8}\sum_{r=1}^{6} S_{ri}\,(d_r - \hat c)$, and every adjacent difference keeps the variance $\sigma^2/4$ (checked numerically).
2. **Row every race twice with the shells swapped** (12 races), which cancels any constant shell or lane effect exactly, at twice the cost.

If you know the shells are well matched, the six-race version can be used as it is. Either way, six races, and seven with the check, leave no spare equation for estimating $\sigma$.

## Expected differences between boats

Taking one rank step as $\delta$, the prior predicts the margin of each race before it is rowed. With $\delta = 0.5$ s (a step of about 3% of a rower's power), 800 m in 200 s is 4 m/s.

| Race | Splits (stroke/bow) | Expected margin | In seconds | In metres |
|---|---|---|---|---|
| R1 | A / C | $4\delta$ | 2.0 s | about 8 m |
| R2 | A / C | $4\delta$ | 2.0 s | about 8 m |
| R3 | B / B | $4\delta$ | 2.0 s | about 8 m |
| R4 | B / B | $0$ | 0 s | 0 m |
| R5 | C / A | $4\delta$ | 2.0 s | about 8 m |
| R6 | C / A | $4\delta$ | 2.0 s | about 8 m |

Boat 1 is expected to be the faster crew in all of them. With a coxless four of about 12 m, an expected margin of 2 s is roughly two thirds of a boat length. For an orthogonal design the total of the squared margins is fixed by the prior ($80\,\delta^2$), so unevenness can be moved between races but not removed. This arrangement spreads it so that the largest margin is as small as possible. The other schedules with the same accuracy are worse:

| Arrangement | Largest expected margin | Largest side imbalance | Precision of adjacent gaps |
|---|---|---|---|
| **Recommended** (A/C, B/B, C/A, each in both signs) | $4\delta$ | $2\delta$ | best, $\sigma^2/4$ |
| A/B, B/A, C/C | $6\delta$ | $3\delta$ | best |
| A/A, B/B, C/C | $8\delta$ | $4\delta$ | best |
| Close races only | $2\delta$ | $3\delta$ | gaps 2–3 are twice as noisy ($\sigma^2/2$) |
| Lowest imbalance | $6\delta$ | $1\delta$ | gaps 2–3 are twice as noisy |

## Power differences between sides in each boat

A boat with more power on one side than the other is harder to steer straight. The prior predicts this too. For a boat, let the *imbalance* $I$ be the sum of the prior advantages of its two stroke-side rowers minus that of its two bow-side rowers. The two boats in a race have the same $|I|$ with opposite signs.

| Race | Boat 1: stroke side / bow side | Boat 2: stroke side / bow side | Imbalance $\lvert I\rvert$ |
|---|---|---|---|
| R1 | 5 / 3 | 1 / 3 | $2\delta$ |
| R2 | 5 / 3 | 1 / 3 | $2\delta$ |
| R3 | 4 / 4 | 2 / 2 | $0$ |
| R4 | 4 / 2 | 2 / 4 | $2\delta$ |
| R5 | 3 / 5 | 3 / 1 | $2\delta$ |
| R6 | 3 / 5 | 3 / 1 | $2\delta$ |

(Prior advantage in rank steps: 3 for rank 1, 0 for rank 4.) With a rank step of 3% of a rower's power, $2\delta$ is 6% of one rower's power, or about **1.5% of a boat's power**. That is small, and it is the same size in both boats.

It cannot be made zero for free. Let $a$ and $b$ be the stroke-side and bow-side advantages of Boat 1 over Boat 2. Then

$$
m = a + b, \qquad I = \frac{a - b}{2}.
$$

If the strong stroke pair and the strong bow pair are in the same boat, the sides are balanced but the margin is large. If they are in opposite boats the race is even but the sides are unbalanced. In this schedule R3 is perfectly balanced across the sides but expected to be decided by $4\delta$, and R4 is expected to be even but has an imbalance of $2\delta$. No full-rank arrangement has a largest margin of $4\delta$ or less together with an imbalance below $2\delta$.

Does the imbalance spoil the ranking? To first order, no. If each boat loses an amount $g(I)$ that depends only on its own imbalance, then the margin changes by $g(-I) - g(I)$. A symmetric penalty cancels exactly, because both boats have the same $|I|$. A penalty linear in $I$ just rescales the stroke-side effects against the bow-side effects, and the schedule estimates the two sides separately, so the order within a side is unchanged. What can leak in is steering that depends on the course (a bend or cross wind), higher-order effects or crews adapting. All of these grow with $|I|$, which is the reason for keeping it at $2\delta$.

## Noise, and where the thresholds come from

Each race margin is the difference of two boat times, so the noise of the two boats adds. I assume three independent sources per boat, and one that cancels:

- **Rower variation** (default 1.5% per rower per race, including differential fatigue). A boat's power is the mean of four rowers, so its relative variation is $s/\sqrt{4}$. Boat time scales as power to the power $-k$ with $k = 1/3$, so one boat's time varies by $t k s/\sqrt{4} = 0.5$ s.
- **Conditions** (wind, stream, lane, steering and start; default $\sigma_c = 0.4$ s per boat).
- **Timing** (reading the time of each boat, default $\sigma_t = 0.7$ s per boat, each boat timed separately). If the same start signal and finish line are used for both boats this may be an overestimate.
- **Fatigue common to all rowers** adds nothing. If everyone loses a fraction $\phi$ of power in a race, both boats slow equally and the margin only rescales by $1+k\phi$, below 2% by the sixth race at 1% per race.

$$
\sigma = \sqrt{2\left[\left(\frac{t k s}{2}\right)^2 + \sigma_c^2 + \sigma_t^2\right]} = \sqrt{2\,(0.5^2 + 0.4^2 + 0.7^2)} \approx 1.34\ \mathrm{s}.
$$

Timing accounts for 54% of the variance, the rowers for 28% and the conditions for 18%. If 0.7 s was meant as the error of the margin itself, not of each boat, then $\sigma \approx 1.14$ s.

The difference of two rowers' totals then has standard error $2\sigma \approx 2.7$ s, and a difference of $2z\sigma$ gives a one-sided confidence of $\Phi(z)$ that the order is right, with a flat prior. For example, $z = 1.645$ gives 4.4 s (95%). The thresholds scale in proportion to $\sigma$:

| Margin noise $\sigma$ | 90% | 95% | 99% |
|---|---|---|---|
| 0.75 s | 1.9 s | 2.5 s | 3.5 s |
| 0.92 s (timing error 0.1 s per boat) | 2.3 s | 3.0 s | 4.3 s |
| 1.14 s (0.7 s on the margin itself) | 2.9 s | 3.8 s | 5.3 s |
| **1.34 s (default)** | 3.4 s | 4.4 s | 6.2 s |
| 2.0 s | 5.1 s | 6.6 s | 9.3 s |

Each entry is the smallest difference in total time over the six races. Converted to power, $\Delta P / P \approx (4/k)\,(\Delta t / t)$, with $\Delta t$ the average margin per race, the total divided by four.

A simulation of the whole schedule, with a boat-time model, the default noise and fatigue included (6000 trials per case), gave a standard error of the score difference of 0.66 to 0.68 s against the formula's 0.67 s. It ranked an adjacent pair correctly in 76% of trials when the true gap was 0.5 s (formula 77%) and in 91% when it was 1.0 s (formula 93%), so the formulas are a little optimistic. Rowing the schedule twice divides the standard error of a score difference by $\sqrt{2}$.

## Using the prior in the estimate

The ranking by total time ignores the prior ranking. If you also trust the prior, with true worth $x_i = \mu_i + \text{noise of s.d. } \tau$, the best estimate is a blend,

$$
\hat{x}^{\mathrm{post}} = w\,\hat{x}^{\mathrm{LS}} + (1 - w)\,\mu^{\mathrm c}, \qquad w = \frac{8\tau^2}{8\tau^2 + \sigma^2},
$$

where $\mu^{\mathrm c}$ is the prior with its side mean removed. It reorders two rowers only if the races contradict the prior by more than $\sigma^2/(8\tau^2)$ times the prior gap. With the default noise, a rank step of $\delta = 0.5$ s and 100,000 simulated sides per case, the share of rankings that came out right was:

| How far rowers truly sit from their prior position ($\tau$) | $w$ | Whole side right: prior only | Races only | Blend | Adjacent pairs right: prior only | Races only | Blend |
|---|---|---|---|---|---|---|---|
| 0.25 s (prior accurate) | 0.22 | 77% | 36% | 77% | 92% | 76% | 92% |
| 0.5 s | 0.53 | 37% | 38% | 47% | 76% | 80% | 82% |
| 1.0 s (prior poor) | 0.82 | 16% | 48% | 49% | 64% | 87% | 87% |

At this noise level six races carry modest information. If the prior is accurate, the races add little to it and can even make the ranking worse unless blended. If the prior is poor, the races dominate and the blend matches the plain ranking by total time. The blend never did worse than the better of the two.

## Assumptions and limits

- Margins are linear in rower effects. Boat speed is closer to power to the power $1/3$, so very lopsided races are where this fails first. This is the main reason to prefer even races.
- All eight rowers row in every race, in coxless fours with two rowers per side.
- The noise values (1.5% rower variation, 0.4 s conditions, 0.7 s timing) are my assumptions, not measurements. The thresholds are only as good as these, so estimate your own, for example by rowing the same two crews twice and timing them independently.
- Timing errors are assumed independent between boats and between races.
- Six races leave no degrees of freedom for estimating $\sigma$ and a seventh uses its equation on the shell effect, so $\sigma$ needs an extra race.
- A constant shell or lane advantage is assumed to be the same in every race. A different lane, wind or stream per race is not covered.
- The prior ranking has to be roughly right. The data-only ranking stays unbiased if it is not, but the choice of races and the blended estimate are then less useful.
