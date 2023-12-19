The det_0001 module must implement an FSM that detects the sequence 0001.

    Inputs:
    Data inputs can be integers or nums, and they are processed serially.

    Output:
    Data outputs are also binary numbers, being 1 when identifying the sequence 0001 and 0 when not identifying.

    Transaction Definition (Item):
    The Item class is defined as the base transaction.
    It has an input (in) and an output (out).
    A constraint (constraint c1) is applied to the input (in) to ensure a distribution of 20% for 0 and 80% for 1.
    The class contains a method to convert attributes into a string for display purposes (convert2str).

    Sequence Generation (gen_item_seq):
    This class inherits from uvm_sequence and is responsible for generating sequences of transactions (Item).
    It has a random variable (num) representing the total number of items to be generated.
    A soft constraint (constraint c1) is applied to num to ensure it is within the range [10, 50].
    The body task is responsible for generating items according to the specified number.

    Driver (driver):
    The driver is responsible for sending transactions to the Design Under Test (DUT) interface.
    The run_phase task is an infinite loop that gets items from the sequencer and sends them to the virtual interface (vif).

    Monitor (monitor):
    The monitor monitors the virtual interface (vif) for complete transactions.
    When a transaction is detected, it is encapsulated in an Item object and sent to the scoreboard through an analysis port.

    Scoreboard (scoreboard):
    The scoreboard checks the integrity of the data.
    It maintains reference patterns (ref_pattern), observed patterns (act_pattern), and an expected output value (exp_out).
    For each transaction, it checks if the observed output matches the expected output and updates the expected value for the next transaction.

    Agent (agent):
    The agent is an entity containing a driver, a monitor, and a sequencer.
    In the connect_phase method, the driver is connected to the sequencer's item exporter.

    Environment (env):
    The environment is an entity containing an agent and a scoreboard.
    In the connect_phase method, the monitor's analysis port is connected to the scoreboard's analysis port.

    Base Test (base_test):
    The base test instantiates the environment, configures the virtual interface (vif), sets a reference pattern, and generates a sequence of items.

    Specific Test (test_0001):
    A specific test class (test_0001) inherits from the base test.
    It overrides the build_phase function to set a new pattern and restrict the number of generated items.

    DUT Interface (des_if):
    Defines the interface of the Design Under Test (DUT), consisting of signals for clock, reset, input, and output.

    Testbench (tb):
    The testbench module instantiates the DUT, creates the virtual interface, registers the interface in the UVM configuration database, and runs the test.
