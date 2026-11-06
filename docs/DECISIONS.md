# Decisions and deviations log
# Format: what the paper says, what we do, why.

D1 Reward sign: Eq. 5 prints -k(SLA - tau) for violations, which is positive. We use Table 4, 1000(SLA - tau). Sec. 4 text and Fig. 8(b) confirm a negative penalty.
D2 Replica bands: Eq. 4 with n1 = 1, n2 = 4, matching Fig. 8 row labels. n is the mean of readyReplicas sampled every 15 s over the iteration, banded without rounding.
D3 Units: tau in seconds everywhere, SLA = 1.0.
D4 Reward boundary: implemented exactly as Table 4; raw reward logged every iteration.
D5 Calibration: log-station has a workload knob, set once on the AWS worker so warm single-request mean is about 213 ms. Never calibrated on the laptop.
D6 Agent latency source: OpenFaaS gateway Prometheus histogram, mean over the 4 min window. Reported latency comes from the load generator. Both reported.
D7 Load generator: wrk, one thread, many connections, absolute-time schedule (open loop), explicit timeout.
D8 Loss: non-2xx responses, socket errors, and client timeouts at the stated timeout.
D9 Versions: Kubernetes 1.35 via k3s instead of 1.24.3. 1.24 cannot be created on EKS; same minor on every cluster.
D10 Topology: json-server runs on node 1, not a separate machine.
