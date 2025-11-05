from flytekit import task, workflow

@task
def add(a: int, b: int) -> int:
    return a + b

@workflow
def my_basic_wf(x: int = 1, y: int = 2) -> int:
    return add(a=x, b=y)
