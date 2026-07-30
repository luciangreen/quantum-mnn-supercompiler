:- module(state_vector_backend, [
    simulate_state_vector/3
]).

simulate_state_vector(Circuit, State0, result(dense_state_vector, Circuit, State0)).
