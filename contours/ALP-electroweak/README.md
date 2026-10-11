# ALP-electroweak constraints

[Back to models and couplings](../../docs/models.md#axion-like-particles)

The exclusion data come from the [FORESEE ALP-W model](https://github.com/KlingFelix/FORESEE/tree/main/Models/ALP-W). They are distributed as two closed contours:

| File | Excluded region |
| --- | --- |
| `ALP-electroweak-excluded-1-Lab.txt` | Union of the laboratory bounds |
| `ALP-electroweak-excluded-2-CosmoAstro.txt` | SN1987 astrophysical bound |

The laboratory region combines BaBar, CDF, E137, the displaced and prompt E949 searches, KOTO, KTEV, LEP, and the NA62/NA48/2 bounds listed in the FORESEE model.

## Coordinates and boundary order

Each line contains mass in GeV and $`g_W`$ in GeV$`^{-1}`$, using the [interaction convention](../../docs/models.md#axion-like-particles) of `ALP-electroweak`. Vertices follow adjacent boundary points counterclockwise, beginning at the lowest mass; the first point is repeated at the end. Both contours have one connected component and no holes.

The laboratory region is the union of the experimental polygons in $`(\log m_a,\log g_W)`$, where $`m_a`$ is the ALP mass. Its edges follow the source segments and their intersections.

## Coupling conversion

FORESEE defines its weak coupling through

```math
\mathcal L\supset-\frac{g_{aWW}}{4}\,aW^I_{\mu\nu}\widetilde W^{I\mu\nu}.
```

Here $`g_{aWW}`$ is in GeV$`^{-1}`$, and $`W^I_{\mu\nu}`$ and $`\widetilde W^{I\mu\nu}`$ denote the weak field strength and its dual. Equating the absolute interaction coefficients gives

```math
g_W=\frac{\pi}{\alpha_2}|g_{aWW}|=99.54282007883\,|g_{aWW}|,
\qquad
\alpha_2=\frac{\alpha_{\rm em}}{\sin^2\theta_W},
```

with $`\alpha_{\rm em}=1/137.035999177`$ and $`\sin^2\theta_W=0.23122`$, where $`\theta_W`$ is the weak mixing angle. This conversion is included in the distributed tables.

## Plot interpretation

Laboratory exclusions have a solid boundary; SN1987 uses a dashed boundary and lighter shading. The contours keep the finite mass ranges, end caps and physical assumptions of the FORESEE data. Zero-mass closure points are represented at $`10^{-12}`$ GeV to allow logarithmic coordinates. These closing edges define the displayed polygon outside the experimentally resolved boundary.
