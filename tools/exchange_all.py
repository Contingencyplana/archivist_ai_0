import os, runpy, pathlib
root = pathlib.Path(__file__).resolve().parents[1]
os.environ.setdefault("WORKSPACE_ROOT", str(root))
os.environ.setdefault("WORKSPACE_NAME", root.name)
runpy.run_path(r"C:\Users\Admin\high_command_ai_0\tools\exchange_all.py", run_name="__main__")
