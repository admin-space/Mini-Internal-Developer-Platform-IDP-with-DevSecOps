
## Known Issues
- **Loki**: The `loki` ArgoCD Application shows a persistent `Unknown` sync status on this
  local kind cluster, despite the underlying Helm values being correctly configured for
  SingleBinary deployment mode. Root cause appears to be a stale comparison in ArgoCD's
  controller layer that persisted across manifest fixes and repo-server cache clears.
  Prometheus, Grafana, and Tempo provide full metrics/dashboards/tracing coverage for this
  demo independent of Loki; log aggregation via Loki is deferred as a follow-up item.
