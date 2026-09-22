import pytest
from cold_fold.primitives import CodexState, OriginOperator
from cold_fold.verification import verify_fold_invariants

def test_verify_fold_invariants_identity():
    states = [
        CodexState("s1", (1.0, 0.0)),
        CodexState("s2", (0.5, 0.5)),
    ]
    op = OriginOperator("Identity")

    result = verify_fold_invariants(states, op)
    assert result.passed
    assert result.details["invariants_ok"] is True
    assert result.details["num_states"] == 2
