# Troubleshooting

- If module loading fails, run `swipl -q -s prolog/qmsc_loader.pl -g load_qmsc_modules -t halt`.
- If tests fail, run `swipl -q -s test/run_tests.pl -g run_tests -t halt` and inspect the first failing test.
- If a source adapter is unavailable, check adapter diagnostics in the compile report.
