import os, runpy, pathlib

root = pathlib.Path(__file__).resolve().parents[1]
shared_tools = root.parent / "high_command_ai_0" / "tools"

os.environ["WORKSPACE_ROOT"] = str(root)
os.environ["WORKSPACE_NAME"] = root.name
runpy.run_path(str(shared_tools / "exchange_all.py"), run_name="__main__")
