// Seat racing with prior-ranked rowers: a swap matrix.
#set page(paper: "a4", margin: 2cm, numbering: "1")
#set text(size: 10.5pt)
#set par(justify: true)
#set heading(numbering: "1.")
#show heading: set block(above: 1.3em, below: 0.7em)
#show figure.where(kind: table): set figure.caption(position: top)
#show figure: set block(breakable: false)

#let booktab(
  header: (),
  rows: (),
  columns: none,
  align: center,
  caption: none,
  light-every: none,
  size: auto,
) = {
  let cols = if columns == none { header.len() } else { columns }
  let cells = ()
  for (i, r) in rows.enumerate() {
    for c in r { cells.push([#c]) }
    if light-every != none and calc.rem(i + 1, light-every) == 0 and i + 1 < rows.len() {
      cells.push(table.hline(stroke: 0.25pt + luma(160)))
    }
  }
  figure(
    {
      if size != auto { set text(size: size) }
      table(
        columns: cols,
        align: align,
        stroke: none,
        inset: (x: 5pt, y: 3.5pt),
        table.hline(stroke: 0.9pt),
        table.header(..header.map(h => strong(h))),
        table.hline(stroke: 0.5pt),
        ..cells,
        table.hline(stroke: 0.9pt),
      )
    },
    caption: caption,
  )
}

// ---- data (edit the prior here and recompile) -----------------------
// Prior advantage of the rower with prior rank 1..4, in units of delta.
// Equal spacing by default; change to match your own prior power estimates.
#let mu-ss = (3, 2, 1, 0)
#let mu-bs = (3, 2, 1, 0)

// Illustrative absolute power of the weakest rower in units of delta (used only to
// express side imbalance as a percentage of boat power). Replace with your own value.
#let p0 = 40

// Race and noise parameters for Section 7 (illustrative defaults, replace with your own).
#let t-race = 200      // race time in seconds (800 m)
#let k-exp = 1 / 3     // relative change in boat time per relative change in power
#let s-ind = 0.015     // race-to-race sd of one rower's power (fraction), incl. differential fatigue
#let sig-cond = 0.4    // sd in seconds of conditions (wind, stream, lane, steering) on one boat
#let phi-step = 0.01   // common-mode fatigue: loss of power of everyone per race

#let names = ("SS1", "SS2", "SS3", "SS4", "BS1", "BS2", "BS3", "BS4")

// Swap matrices: row = race, column = rower, +1 Boat 1, -1 Boat 2.
#let S-main = ((1, 1, -1, -1, 1, -1, -1, 1), (1, 1, -1, -1, -1, 1, 1, -1), (1, -1, 1, -1, 1, -1, 1, -1), (1, -1, 1, -1, -1, 1, -1, 1), (1, -1, -1, 1, 1, 1, -1, -1), (-1, 1, 1, -1, 1, 1, -1, -1))
#let lab-main = ("A/C +", "A/C −", "B/B +", "B/B −", "C/A +", "C/A −")
#let S-alt = ((1, 1, -1, -1, -1, 1, -1, 1), (1, -1, 1, -1, -1, -1, 1, 1), (1, -1, 1, -1, 1, -1, -1, 1), (1, -1, 1, -1, -1, 1, 1, -1), (1, -1, -1, 1, 1, -1, 1, -1), (1, -1, -1, 1, -1, 1, -1, 1))
#let lab-alt = ("A/B −", "B/A −", "B/C +", "B/C −", "C/B +", "C/B −")
// Synthetic margins used in the worked example (seconds, Boat 1 faster = +).
#let d-ex = (5.1, -0.3, 5.7, 0.7, 3.6, 4.5)

// ---- helpers ----------------------------------------------------------
#let fmt(v) = str(calc.round(v, digits: 3)).replace("-", "−")
#let pm(v) = if v > 0 [+] else if v < 0 [−] else [0]
#let emargin(row) = (
  range(4).map(i => row.at(i) * mu-ss.at(i)).sum()
    + range(4).map(i => row.at(4 + i) * mu-bs.at(i)).sum()
)
#let crew(row, sg) = {
  let ss = range(4).filter(i => row.at(i) == sg).map(i => names.at(i))
  let bs = range(4, 8).filter(i => row.at(i) == sg).map(i => names.at(i))
  ss.join(", ") + " | " + bs.join(", ")
}
#let gram(S) = range(8).map(i => range(8).map(j => range(S.len()).map(r => S.at(r).at(i) * S.at(r).at(j)).sum()))

#let fmt2(v) = str(calc.round(v, digits: 2)).replace("-", "−")
#let phi(z) = {
  let x = calc.abs(z)
  let u = 1 / (1 + 0.2316419 * x)
  let d = 0.3989422804 * calc.exp(-x * x / 2)
  let p = d * u * (0.319381530 + u * (-0.356563782 + u * (1.781477937 + u * (-1.821255978 + u * 1.330274429))))
  if z >= 0 { 1 - p } else { p }
}
#let sig-rowers = calc.sqrt(2) * t-race * k-exp * s-ind / 2
#let sig-cond-m = calc.sqrt(2) * sig-cond
#let sig = calc.sqrt(calc.pow(sig-rowers, 2) + calc.pow(sig-cond-m, 2))
#let se = sig / 2
#let pw-pct(dt) = 100 * (4 / k-exp) * dt / t-race

#let side-sum(row, sg, off, mu) = range(4).filter(i => row.at(off + i) == sg).map(i => mu.at(i)).sum(default: 0)
#let imb(row, sg) = side-sum(row, sg, 0, mu-ss) - side-sum(row, sg, 4, mu-bs)
#let boat-power(row, sg) = 4 * p0 + side-sum(row, sg, 0, mu-ss) + side-sum(row, sg, 4, mu-bs)
#let rel(row, sg) = 100 * calc.abs(imb(row, sg)) / boat-power(row, sg)
#let side-table(S, labels, caption) = booktab(
  header: ([Race], [Split], [B1 SS], [B1 BS], [B1 $I$], [B2 SS], [B2 BS], [B2 $I$], [Worst $|I|$ (%)]),
  rows: S.enumerate().map(((r, row)) => (
    [R#(r + 1)], [#labels.at(r)],
    [#fmt(side-sum(row, 1, 0, mu-ss))], [#fmt(side-sum(row, 1, 4, mu-bs))], [#fmt(imb(row, 1))],
    [#fmt(side-sum(row, -1, 0, mu-ss))], [#fmt(side-sum(row, -1, 4, mu-bs))], [#fmt(imb(row, -1))],
    [#str(calc.round(calc.max(rel(row, 1), rel(row, -1)), digits: 2))],
  )),
  columns: 9,
  caption: caption,
  size: 8.5pt,
)

#let design-table(S, labels, caption) = booktab(
  header: ([Race], [Split]) + names.map(n => [#n]),
  rows: S.enumerate().map(((r, row)) => ([R#(r + 1)], [#labels.at(r)]) + row.map(pm)),
  columns: 10,
  caption: caption,
  size: 9pt,
)
#let crews-table(S, labels, caption) = booktab(
  header: ([Race], [Split], [Boat 1 (SS | BS)], [Boat 2 (SS | BS)], [Expected $d$ (units of $delta$)]),
  rows: S.enumerate().map(((r, row)) => (
    [R#(r + 1)], [#labels.at(r)], [#crew(row, 1)], [#crew(row, -1)], [#fmt(emargin(row))],
  )),
  columns: 5,
  align: (center, center, left, left, center),
  caption: caption,
  size: 9pt,
)

// Self-checks: the main design is orthogonal between sides and within each side.
#let G = gram(S-main)
#assert(range(4).all(i => range(4, 8).all(j => G.at(i).at(j) == 0)))
#assert(range(4).all(i => G.at(i).at(i) == 6) and range(4).all(i => range(4).all(j => i == j or G.at(i).at(j) == -2)))

// ---- document ---------------------------------------------------------
#align(center)[
  #text(size: 17pt, weight: "bold")[Seat racing with prior-ranked rowers]
  #v(2pt)
  #text(size: 11pt)[A swap matrix for 8 rowers, two boats, 6 races]
]

= Model and notation

Four stroke-side rowers SS1–SS4 and four bow-side rowers BS1–BS4 are indexed by _prior power rank_: index 1 is the strongest, index 4 the weakest on that side. Each race has two boats, each with two stroke-side and two bow-side rowers; all eight row in every race. Row $r$ of the swap matrix $S$ holds $+1$ for rowers in Boat 1 and $-1$ for rowers in Boat 2. The margin of race $r$ is $d_r = t_2 - t_1$ (positive if Boat 1 is faster), and

$ d = S x + epsilon, quad "E"(epsilon) = 0, quad "Var"(epsilon) = sigma^2 I, $

where $x_i$ is the number of seconds rower $i$ is worth over the race distance (larger is faster). Every row of $S$ sums to zero on each side, so only differences within a side are identifiable. That is all a within-side ranking needs. Six races give six identifiable contrasts (three per side), so the design is saturated and $sigma$ cannot be estimated from the residuals.

Prior knowledge enters as a prior advantage $mu_i$ for each rower (here $3, 2, 1, 0$ in units of a step $delta$). It lets us predict the margin of any race before it is rowed, $"E"(d) = S mu$, and so choose which races to row.

= The three splits and what the prior says about them

With two rowers per boat per side there are only three ways to split four rowers, up to swapping the boats:

#booktab(
  header: ([Split], [Boats], [Contrast], [Expected $d$ from this side ($delta$)], [Adjacent pairs in opposite boats]),
  rows: (
    ([A], [1,2 v 3,4], [$x_1 + x_2 - x_3 - x_4$], [#fmt(mu-ss.at(0) + mu-ss.at(1) - mu-ss.at(2) - mu-ss.at(3))], [2/3 only]),
    ([B], [1,3 v 2,4], [$x_1 + x_3 - x_2 - x_4$], [#fmt(mu-ss.at(0) + mu-ss.at(2) - mu-ss.at(1) - mu-ss.at(3))], [1/2, 2/3, 3/4]),
    ([C], [1,4 v 2,3], [$x_1 + x_4 - x_2 - x_3$], [#fmt(mu-ss.at(0) + mu-ss.at(3) - mu-ss.at(1) - mu-ss.at(2))], [1/2, 3/4]),
  ),
  align: (center, center, left, center, left),
  caption: [The three splits of one side (stroke-side values shown; sign depends on which boat gets which pair).],
  size: 9pt,
)

With contrasts $A$, $B$, $C$ every difference is recovered:
$ x_1 - x_2 = (B + C)/2, quad x_2 - x_3 = (A - B)/2, quad x_3 - x_4 = (B - C)/2. $
Three consequences follow.
+ Split A, the strong pair against the weak pair, is the only split that links the top pair to the bottom pair. Without it, $x_2 - x_3$ is not identifiable from the data. It cannot be dropped from a pure data design, and the uneven race is the price of measuring the 2/3 gap.
+ The margin of a race is the stroke contrast plus or minus the bow contrast. Which boat receives which pair is free, so an imbalance on one side can be partly offset by the other side.
+ If the design is _orthogonal_ ($S^top S$ proportional to the centring matrix on each side), then every adjacent difference has the minimum possible variance, $sigma^2 / 4$. The total of the squared expected margins, $|S mu|^2$, is then fixed by the prior, so unevenness can only be redistributed between races, not removed. The best redistribution has the largest expected margin as small as possible.

= Recommended swap matrix

Among the six orthogonal designs, the one below has the smallest largest expected margin ($4 delta$ for equal spacing). One of its six races is expected to be dead even, and none is as lopsided as the $6 delta$ or $8 delta$ races of the other orthogonal designs. It pairs each uneven split on one side with the balanced split C on the other, and the middle split B with itself in both signs.

#design-table(S-main, lab-main, [Recommended swap matrix $S$. Split = stroke-side split / bow-side split, followed by the relative sign of the bow-side assignment.])

#crews-table(S-main, lab-main, [Who rows in which boat, and the margin predicted by the prior (editable above).])

Properties (checked when this document is compiled):
- the numbers of races in Boat 1 and Boat 2 are _not_ equal for every rower (counts in Section 4.2), which matters if one hull or lane is faster;
- every pair of rowers on the same side is in the same boat twice and in opposite boats four times;
- the stroke-side and bow-side columns are orthogonal, so the two sides are estimated independently.

The order of the races can be shuffled freely. Which crew is called Boat 1 is not free: Boat 1 should be the same hull and lane in every race, and Section 4.2 explains why R6 is relabelled in this matrix and why a seventh race is suggested. Section 6 checks the same matrix for side balance within each boat.

#figure(
  {
    set text(size: 9pt)
    table(
      columns: (auto,) * 9,
      align: center,
      stroke: none,
      inset: (x: 5pt, y: 3pt),
      table.hline(stroke: 0.9pt),
      table.header([], ..names.map(n => strong(n))),
      table.hline(stroke: 0.5pt),
      ..range(8).map(i => (strong(names.at(i)),) + range(8).map(j => [#str(G.at(i).at(j)).replace("-", "−")])).flatten(),
      table.hline(stroke: 0.9pt),
    )
  },
  caption: [$S^top S$ for the recommended design: $8 (I - J slash 4)$ on each side, zero between sides.],
)

= Is the result still obtained by ranking rowers by time raced?

*Yes.* The prior was used only to choose the design, and the design is orthogonal. Per side $S^top S = 8 (I - J slash 4)$, where $J$ is the all-ones matrix, so the least-squares solution $hat(x) = (S^top S)^+ S^top d$ reduces to

$ hat(x)_i = 1/8 sum_r S_(r i) d_r . $

The score of a rower is the signed sum of the race margins: add the margin of every race in which they were in Boat 1, subtract it for every race in which they were in Boat 2 (equivalently, the time their boat won by, summed over races). Dividing by 8 gives seconds; for ranking it does not matter. Ranking by this sum is the least-squares ranking, with no matrix inversion needed. Every adjacent difference has the same variance $sigma^2 / 4$. This assumes that Boat 1 and Boat 2 are interchangeable; Section 4.2 relaxes that.

#let sc = range(8).map(i => range(6).map(r => S-main.at(r).at(i) * d-ex.at(r)).sum() / 8)
#let rk(off) = {
  let idx = range(4).sorted(key: i => -sc.at(off + i))
  range(4).map(i => idx.position(k => k == i) + 1)
}
#let ranks = rk(0) + rk(4)
#booktab(
  header: ([Rower], [Score $hat(x)$ (s)], [Rank from races], [Prior rank]),
  rows: range(8).map(i => ([#names.at(i)], [#fmt(sc.at(i))], [#ranks.at(i)], [#(calc.rem(i, 4) + 1)])),
  columns: 4,
  caption: [Worked example with synthetic margins $d = $ #d-ex.map(v => fmt(v)).join(", ") s. Not real data.],
  light-every: 4,
  size: 9pt,
)

== With the prior in the estimate

If the prior is also used in the estimate, taking the true advantages as $x_i tilde mu_i + $ noise of standard deviation $tau$, the posterior mean on each side is a blend of the least-squares score and the centred prior,

$ hat(x)^"post" = w hat(x)^"LS" + (1 - w) mu^"c", quad w = (8 tau^2) / (8 tau^2 + sigma^2), $

where $mu^"c"$ is the prior with its side mean removed. This is still easy to compute, but it is no longer exactly the ranking by time raced: rower $j$ (weaker prior) overtakes rower $i$ only if the races say $hat(x)^"LS"_j - hat(x)^"LS"_i > sigma^2 / (8 tau^2) (mu_i - mu_j)$. When $tau$ is not small compared with $sigma$, that hurdle is small, because six races on four rowers carry a lot of information. The prior then acts as a tie-breaker, and ranking by time raced is a very good approximation.

#figure(
  {
    set text(size: 9pt)
    table(
    columns: (auto,) * 8,
    align: (center,) * 8,
    stroke: none,
    inset: (x: 5pt, y: 3.5pt),
    table.hline(stroke: 0.9pt),
    table.header([*τ/δ*], [*w*], [*All four right: prior*], [*LS*], [*Bayes*], [*Adjacent pairs right: prior*], [*LS*], [*Bayes*]),
    table.hline(stroke: 0.5pt),
    [0.5],
    [0.67],
    [0.77],
    [0.73],
    [0.82],
    [0.92],
    [0.91],
    [0.94],
    [1.0],
    [0.89],
    [0.37],
    [0.69],
    [0.71],
    [0.76],
    [0.91],
    [0.92],
    [2.0],
    [0.97],
    [0.16],
    [0.76],
    [0.76],
    [0.64],
    [0.95],
    [0.95],
    table.hline(stroke: 0.9pt)
  )},
  caption: [Synthetic check, $sigma = delta$, 40 000 trials, per side. Prior = prior order only; LS = rank by signed margin sums; Bayes = blend.],
)

The simulation (synthetic) shows when the blend matters. If the prior is accurate ($tau = 0.5 delta$), the blend ranks best and the data-only ranking is worse than the prior alone. When the prior is poor ($tau = 2 delta$), the blend and the data-only ranking agree.

== A constant hull or lane advantage <hull>

So far the two boats were assumed interchangeable. Suppose instead that Boat 1 (always the same hull and lane) is faster by $c$ seconds. Every margin is then shifted by $c$, and the score of rower $i$ shifts by $c (n_(1,i) - n_(2,i)) / 8$, where $n_(1,i)$ and $n_(2,i)$ are the numbers of races rower $i$ spends in Boat 1 and Boat 2.

#let n1(S, i) = range(S.len()).filter(r => S.at(r).at(i) > 0).len()
#booktab(
  header: ([Rower], [Races in Boat 1], [Races in Boat 2], [Score shift per second of hull advantage]),
  rows: range(8).map(i => ([#names.at(i)], [#n1(S-main, i)], [#(S-main.len() - n1(S-main, i))], [#fmt((2 * n1(S-main, i) - S-main.len()) / 8)])),
  columns: 4,
  caption: [Boat counts of the recommended matrix and the resulting bias from a constant hull or lane advantage.],
  light-every: 4,
  size: 9pt,
)

The counts are unequal, so a hull advantage is not cancelled: it makes SS1 look better than SS4 by $c$ seconds although the two row identically. This cannot be avoided by relabelling alone. Any full-rank six-race design has $S^top$ injective, so no choice of boat labels makes all eight counts equal, and the sum of squared shifts is $0.75 c^2$ however the boats are labelled. Relabelling R6, as in the matrix above, only spreads the bias more evenly: the largest shift between adjacent ranks falls from $c$ to $0.5 c$.

Two ways to deal with it:
+ *Estimate it with a seventh race.* Row R4 again with the crews' hulls swapped, that is, R7 $= -$R4. R4 is chosen because it is expected to be dead even. The two margins give $hat(c) = (d_4 + d_7) / 2$, the rower effect cancels from that sum, and the scores are
$ hat(x)_i = 1/8 sum_(r = 1)^6 S_(r i) (d_r - hat(c)). $
With the hull effect estimated this way, every adjacent difference still has variance $sigma^2 / 4$ (checked numerically). The seven margins leave seven unknowns, so there is still no residual degree of freedom for $sigma$.
+ *Row each race twice with the boats swapped* (12 races). This cancels any constant hull or lane effect exactly, at twice the cost.

If the hull and lane difference is known to be small compared with the rower differences you care about, the six-race matrix can be used as it stands, with Boat 1 always the same hull and lane. The model assumes the advantage is the same in every race; a different lane, wind or stream per race is not covered.

= Alternative: close races only

If the largest allowed expected margin is $2 delta$ (for example because crews give up in lopsided races), the design below keeps every race within $2 delta$ of even. It is not orthogonal, so the simple signed sum is no longer exact. Use the weights $W = S^+$ instead.

#design-table(S-alt, lab-alt, [Alternative swap matrix with all expected margins at most $2 delta$ in size.])
#crews-table(S-alt, lab-alt, [Boats and predicted margins for the alternative design.])

#figure(
  {
    set text(size: 9pt)
    table(
    columns: (auto,) * 7,
    align: (left,) + (center,) * 6,
    stroke: none,
    inset: (x: 5pt, y: 3.5pt),
    table.hline(stroke: 0.9pt),
    table.header([*Rower*], [*R1*], [*R2*], [*R3*], [*R4*], [*R5*], [*R6*]),
    table.hline(stroke: 0.5pt),
    [SS1],
    [0.250],
    [0.000],
    [0.125],
    [0.125],
    [0.250],
    [0.000],
    [SS2],
    [0.250],
    [0.000],
    [−0.125],
    [−0.125],
    [0.000],
    [−0.250],
    [SS3],
    [−0.250],
    [0.000],
    [0.125],
    [0.125],
    [−0.250],
    [0.000],
    [SS4],
    [−0.250],
    [0.000],
    [−0.125],
    [−0.125],
    [0.000],
    [0.250],
    table.hline(stroke: 0.25pt + luma(160)),
    [BS1],
    [0.000],
    [−0.250],
    [0.250],
    [0.000],
    [0.125],
    [−0.125],
    [BS2],
    [0.000],
    [−0.250],
    [0.000],
    [0.250],
    [−0.125],
    [0.125],
    [BS3],
    [0.000],
    [0.250],
    [−0.250],
    [0.000],
    [0.125],
    [−0.125],
    [BS4],
    [0.000],
    [0.250],
    [0.000],
    [−0.250],
    [−0.125],
    [0.125],
    table.hline(stroke: 0.9pt)
  )},
  caption: [Alternative design: weights $W = S^+$ in $hat(x) = W d$ (seconds per second of margin).],
)

#figure(
  {
    set text(size: 9pt)
    table(
    columns: (auto,) * 8,
    align: (left,) + (center,) * 7,
    stroke: none,
    inset: (x: 5pt, y: 3.5pt),
    table.hline(stroke: 0.9pt),
    table.header([*Design*], [*SS1−SS2*], [*SS2−SS3*], [*SS3−SS4*], [*BS1−BS2*], [*BS2−BS3*], [*BS3−BS4*], [*max |E[d]|*]),
    table.hline(stroke: 0.5pt),
    [Main (orthogonal)],
    [0.25],
    [0.25],
    [0.25],
    [0.25],
    [0.25],
    [0.25],
    [4],
    [Alternative (close races)],
    [0.25],
    [0.50],
    [0.25],
    [0.25],
    [0.50],
    [0.25],
    [2],
    table.hline(stroke: 0.9pt)
  )},
  caption: [Variance of adjacent-rank differences in units of $sigma^2$; last column in units of $delta$.],
)

The price is a larger variance for the 2/3 gaps ($0.5 sigma^2$ against $0.25 sigma^2$), so rowers ranked 2 and 3 on either side are separated less well. It has the same hull-balance problem as the recommended matrix, more strongly: SS1 is in Boat 1 in all six races. The remedies of Section 4.2 apply, but I have not worked them out for this matrix. It also has larger side imbalances within the boats ($3 delta$ against $2 delta$, Section 6), so choose it only if lopsided races are the bigger worry.

= Side balance within a boat (steering)

A boat with more power on one side than the other is harder to steer straight. The prior predicts this before the race. For a boat let $P_"s"$ and $P_"b"$ be the sums of the prior advantages of its two stroke-side and two bow-side rowers, and define the side imbalance $I = P_"s" - P_"b"$ (positive if the boat is stroke-side heavy). Let $a_r$ be the stroke-side advantage of Boat 1 over Boat 2 in race $r$, and $b_r$ the bow-side one. The expected margin is $m_r = a_r + b_r$. If the two sides have equal total prior power, the boat-level imbalance of Boat 1 is

$ I_r = (a_r - b_r) / 2, $

and that of Boat 2 is $-I_r$. Both boats therefore carry the same $|I|$, in opposite directions. Solving for $a_r$ and $b_r$ gives two facts.

+ *Margin and side balance pull against each other.* If the strong stroke pair and the strong bow pair are in the same boat ($a = b$), side balance is perfect and the margin is the largest. If they are in opposite boats ($a = -b$), the race is expected to be dead even and the side imbalance is the largest. Within a race, $m^2 + 4 I^2 = 2 (a^2 + b^2)$ is fixed by the splits used.
+ *For an orthogonal design the totals are fixed by the prior.* The cross terms vanish, so $sum_r m_r^2 = sum_r a_r^2 + sum_r b_r^2 = #fmt(range(6).map(r => calc.pow(emargin(S-main.at(r)), 2)).sum()) delta^2$ and $sum_r I_r^2 = 1/4 sum_r m_r^2 = #fmt(range(6).map(r => calc.pow(imb(S-main.at(r), 1), 2)).sum()) delta^2$. A design can move imbalance between races and trade it against margin, but not remove either.

#side-table(S-main, lab-main, [Prior power of the two stroke-side (SS) and two bow-side (BS) rowers in each boat and the imbalance $I$ (units of $delta$), recommended design. Last column: worst $|I|$ as a percentage of that boat's power, using the illustrative baseline `p0` at the top of the file.])

In the recommended design R3 is perfectly balanced across the sides but expects a $4 delta$ margin, R4 is expected to be dead even but has a side imbalance of $2 delta$ in each boat, and R1, R2, R5 and R6 have both a $4 delta$ margin and a $2 delta$ imbalance. No race has an imbalance beyond $2 delta$; with the illustrative baseline this is about #calc.round(calc.max(..S-main.map(row => calc.max(rel(row, 1), rel(row, -1)))), digits: 1) per cent of boat power at worst, so steering should be a minor effect unless $delta$ is large compared with the rowers' power.

== Is the ranking affected?

Under a first-order model in which each boat loses an amount depending only on its own imbalance, $g(I)$, the margin of race $r$ changes by $-g(I_r) + g(-I_r)$ (Boat 2 has $-I_r$). Two cases follow.
- A symmetric penalty ($g$ even, for example proportional to $I^2$) cancels exactly, because both boats have the same $|I|$.
- A penalty linear in $I$, $g(I) = kappa I$, changes the margin by $-kappa (a_r - b_r)$, so that $d = (1 - kappa) S_"s" x_"s" + (1 + kappa) S_"b" x_"b"$. The stroke-side and bow-side effects are rescaled in opposite directions, but because the recommended design is orthogonal between sides, the within-side ranking is unchanged. Only comparisons between a stroke-side and a bow-side rower would be distorted, and the design makes none.

Terms that are odd and non-linear in $I$, steering that depends on the course (a bend, a cross wind) or crews adapting to the imbalance leak into the margins. Their size grows with $|I|$, so they are the reason to keep the largest imbalance small.

== Trade-off across designs

#figure(
  {
    set text(size: 8.5pt)
    table(
    columns: (auto,) * 7,
    align: (left, left) + (center,) * 5,
    stroke: none,
    inset: (x: 5pt, y: 3.5pt),
    table.hline(stroke: 0.9pt),
    table.header([*Design*], [*Splits*], [*Max |E[d]|*], [*Max |I|*], [*Σ I²*], [*Mean var.*], [*Worst var.*]),
    table.hline(stroke: 0.5pt),
    [Recommended (orthogonal)],
    [AC±, BB±, CA±],
    [4],
    [2],
    [20],
    [0.25],
    [0.25],
    [Orthogonal, larger margins],
    [AB±, BA±, CC±],
    [6],
    [3],
    [20],
    [0.25],
    [0.25],
    [Orthogonal, largest margins],
    [AA±, BB±, CC±],
    [8],
    [4],
    [20],
    [0.25],
    [0.25],
    [Close races (alternative)],
    [AB−, BA−, BC±, CB±],
    [2],
    [3],
    [22],
    [0.33],
    [0.50],
    [Lowest imbalance found],
    [AB+, BA+, BC±, CB±],
    [6],
    [1],
    [6],
    [0.33],
    [0.50],
    table.hline(stroke: 0.9pt)
  )},
  caption: [Margin, side imbalance (units of $delta$) and variance of adjacent differences (units of $sigma^2$) for five designs.],
)

Among all full-rank designs built from the three splits (equal prior spacing), none has a largest expected margin of $4 delta$ or less together with a largest imbalance below $2 delta$, and none has a largest margin of $2 delta$ or less together with a largest imbalance below $3 delta$. Reducing the imbalance to $1 delta$ needs margins up to $6 delta$ and costs variance. The recommended design is the best orthogonal compromise: it has the smallest largest margin and the smallest largest imbalance of the six orthogonal designs at the same time.

= How large a difference is meaningful? (800 m, 200 s races)

This section asks what size of difference between two rowers' scores can be told apart from noise, for the recommended six-race design with races of about #t-race s over 800 m. All noise values below are *illustrative defaults*, set at the top of the file (`t-race`, `k-exp`, `s-ind`, `sig-cond`, `phi-step`), not measurements. Replace them with values from your own repeated races.

The score $hat(x)_i$ is in seconds over the race. The difference $hat(x)_i - hat(x)_j$ is the number of seconds a four gains over #t-race s when rower $j$ is replaced by rower $i$ in the same seat. It is not the margin of a single race: it is a quarter of the total time difference between the two rowers' crews accumulated over the six races (see below).

== Noise in a race margin

The margin of one race is the difference of two boat times, so the noise of the two boats adds. Three sources are considered.
- *Rower-to-rower variation.* Each rower's power in a race varies by a fraction $s$ (here #fmt(100 * s-ind)%), including rowers who fade more than others. A boat's power is the mean of four rowers, so its relative variation is $s / sqrt(4)$. Boat time varies as power to the power $-k$ ($k$ = #fmt(k-exp)), so one boat's time has standard deviation $t k s / sqrt(4)$ = #fmt2(t-race * k-exp * s-ind / 2) s.
- *Conditions.* Wind, stream, lane, steering and start variation, here #fmt2(sig-cond) s per boat, independent between the boats.
- *Fatigue common to all rowers.* If everyone loses a fraction $phi_r$ of power in race $r$, both boats slow by the same amount and the margin is unchanged to first order. It only rescales the margin by $1 + k phi_r$, which is at most #fmt2(100 * k-exp * phi-step * 6)% by the sixth race with the default #fmt(100 * phi-step)% per race. A Monte Carlo run with this fatigue included gave the same results as without it. Only fatigue that differs between rowers matters, and it is in the first source.

#booktab(
  header: ([Source], [One boat (s)], [Margin of a race (s)]),
  rows: (
    ([Rower-to-rower variation], [#fmt2(sig-rowers / calc.sqrt(2))], [#fmt2(sig-rowers)]),
    ([Conditions], [#fmt2(sig-cond)], [#fmt2(sig-cond-m)]),
    ([Common-mode fatigue], [0], [≈ 0 (rescales margins)]),
    ([*Total*], [#fmt2(sig / calc.sqrt(2))], [*#fmt2(sig)*]),
  ),
  columns: 3,
  align: (left, center, center),
  caption: [Noise budget for a race margin. The total margin standard deviation is $sigma$.],
  size: 9pt,
)

== Standard error of a rower comparison

In the recommended design two rowers on the same side are in opposite boats in four of the six races, and $S_(r i) - S_(r j) = plus.minus 2$ there and $0$ in the other two. The estimator of Section 4 therefore gives exactly

$ hat(x)_i - hat(x)_j = 1/4 sum_(r in "opposite") S_(r i) d_r, $

the average of the four margins taken positive when $i$'s boat wins. The four races contribute independent noise of standard deviation $sigma$, so

$ "SE"(hat(x)_i - hat(x)_j) = sigma / 2 = #fmt2(se) "s". $

This is the same for every pair of rowers on a side.

=== Total time over the six races

Each rower races six times, so each rower has a cumulative time, the sum of the times of the boats they rowed in, $T_i = sum_r t_(b(i), r)$. In the two races where $i$ and $j$ are in the same boat their times are identical, so the difference of their totals comes only from the four races in which they are in opposite boats:

$ T_j - T_i = sum_(r in "opposite") S_(r i) d_r = 4 (hat(x)_i - hat(x)_j). $

It is positive when $i$'s crews were faster in total. In this design the partners and the other side cancel exactly in expectation, so $"E"(T_j - T_i) = 4 (x_i - x_j)$: comparing raw cumulative times after six races is unbiased. The four margins are independent, so

$ "SE"(T_j - T_i) = 2 sigma = #fmt2(2 * sig) "s". $

The tables below are therefore in both forms: the cumulative difference over the six races, and the same number divided by four as an average margin per race. For comparing two rowers' total times, use the cumulative column. The noise of #fmt2(sig) s is per race margin; it grows as $sqrt(4)$ in the total while the signal grows as 4, which is why the total is more informative than any single race.

A single race margin has standard deviation $sigma$ = #fmt2(sig) s, which is as large as many real differences, so single races should not be read in isolation.

== Differences that are meaningful

#let zs = ((75, 0.674), (90, 1.282), (95, 1.645), (97.5, 1.960), (99, 2.326))
#booktab(
  header: ([Order right (prob.)], [$z$], [Total-time difference, 6 races (s)], [Per race, average (s)], [Power diff. (%)]),
  rows: zs.map(p => (
    [#p.at(0)%], [#fmt(p.at(1))], [#fmt2(4 * p.at(1) * se)], [#fmt2(p.at(1) * se)], [#fmt(calc.round(pw-pct(p.at(1) * se), digits: 1))],
  )),
  columns: 5,
  caption: [Smallest observed difference in cumulative time over the six races (and its per-race average, equal to $hat(x)_i - hat(x)_j$) for a given confidence, with a flat prior. 97.5% is the usual two-sided 95% test. The last column converts the seconds to a rower power difference using $4 / k times$ (seconds / race time).],
  size: 9pt,
)

With the default noise, a cumulative time difference of about #fmt2(4 * 1.645 * se) s over the six races (#fmt2(1.645 * se) s per race on average) gives 95% confidence that the order is right, and about #fmt2(4 * 1.960 * se) s (#fmt2(1.960 * se) s per race) is needed for the usual two-sided test. For the #(6 * t-race) s of total racing, #fmt2(4 * 1.960 * se) s is #fmt2(100 * 4 * 1.960 * se / (6 * t-race))% of the total time. In power terms that is a difference of roughly #fmt(calc.round(pw-pct(1.960 * se), digits: 0))% between two rowers, because one rower is a quarter of a boat and time depends on power to the power $k$. Smaller differences are within chance with these six races.

== What the design can resolve

The table gives the probability that an adjacent pair comes out in the right order, $Phi (Delta / (sigma slash 2))$, when the true difference is $Delta$.

#let sigs = (0.5, 0.75, 1.0, 1.5)
#let deltas = (0.25, 0.5, 0.75, 1.0, 1.5, 2.0)
#booktab(
  header: ([True difference $Delta$ (s)], [Power (%)]) + sigs.map(s => [$sigma$ = #s s]),
  rows: deltas.map(d => (
    [#d], [#fmt(calc.round(pw-pct(d), digits: 1))],
  ) + sigs.map(s => [#calc.round(100 * phi(d / (s / 2)), digits: 0)%])),
  columns: 6,
  caption: [Probability of ranking an adjacent pair correctly. The default noise gives $sigma$ = #fmt2(sig) s, between the $sigma$ = 0.75 s and $sigma$ = 1 s columns.],
  size: 9pt,
)

A simulation of the whole design (6000 trials per case, with the boat-time model and the default noise including fatigue; static results) agrees with these formulas. The standard deviation of a score difference came out at 0.44 to 0.46 s against the formula's #fmt2(se) s. When the three adjacent differences on a side are equal, the probability that the whole side of four is ranked correctly is about 0.59 for 0.5 s, 0.93 for 1.0 s and 0.99 for 1.5 s; for equal rowers the order is a coin flip.

== Practical reading

- Treat cumulative time differences over the six races below about #fmt2(4 * 1.282 * se) s (90%) as inconclusive. Differences above about #fmt2(4 * 1.960 * se) s are reasonably safe, and the ones between depend on how much a wrong order costs.
- Adjacent rowers whose true difference is below about #fmt(calc.round(pw-pct(0.5), digits: 0))% power ($Delta$ about 0.5 s) cannot be ranked reliably by six races. Further races help: repeating the design (12 races) lowers the standard error to #fmt2(sig / (2 * calc.sqrt(2))) s. A classical single swap (two races) would have #fmt2(sig / calc.sqrt(2)) s.
- The prior helps most when differences are small: with $tau$ not large the blend of Section 4.1 acts as a tie-breaker, and its gain in the earlier synthetic check ranged from about 1 to 9 percentage points of correct rankings, largest when the prior was accurate.
- The noise values are the weakest input. A good estimate of $sigma$ comes from rowing the same two crews twice, or from the spread of races that are expected to be dead even; that is worth more than any of the defaults.

= Practical notes

- The prior spacing is editable at the top of this file (`mu-ss`, `mu-bs`); the expected margins and tables update on recompile. The choice of design above assumed equal spacing; with very uneven spacing re-check which design has the smallest largest margin.
- The model is linear in margins. Boat speed is closer to the cube root of power, so very lopsided races are the ones where it fails first. This is the main reason to prefer even races.
- Six races leave no degrees of freedom for estimating $sigma$. The seventh race of Section 4.2 is used up estimating the hull effect, so estimating $sigma$ needs an eighth race, for example a repeat of R3 with the boats swapped (not analysed here).
- The prior is only as good as the ranking. If a rower is far from their prior rank, the data-only ranking (signed margins) stays unbiased, while the blended one is pulled towards the prior.
- Side imbalance is predicted from the prior in the same way as the margin, so it can be recomputed for any other design or prior by editing the arrays at the top of the file. If steering turns out to be a problem in practice, the first race to change is one with a $2 delta$ imbalance and a $4 delta$ margin (R1, R2, R5, R6); moving it towards the balanced split B on the other side lowers the imbalance but raises the margin.
