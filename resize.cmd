for /F "usebackq" %%g in (`cols`) do (
  set COLUMNS=%%g
  setx COLUMNS %%g
)
