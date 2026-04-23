# ============================================
# Makefile for UVM Testbench (00.UVM)
# ============================================

# Simulation parameters
SV_SEED ?= random
UVM_VERBOSITY ?= UVM_MEDIUM
TESTNAME ?= test

# Coverage directory
COV_DIR := $(wildcard cov_work/scope/test_sv*)

# Directories
AGENTS_DIR := agents
ENV_DIR := env
RTL_DIR := rtl
SEQUENCE_DIR := sequence
SIM_DIR := sim
TOP_DIR := top

# Output file settings
WAVES_DB := waves.shm
XCELIUM_DIR := xcelium.d

# ============================================
# Simulation target
# ============================================
sim:
	xrun -access +r -uvm \
		+uvm_set_config_int="*",recording_detail,1 \
		-coverage all -covoverwrite \
		-top top \
		+UVM_VERBOSITY=$(UVM_VERBOSITY) \
		-svseed $(SV_SEED) \
		+UVM_TESTNAME=$(TESTNAME) \
		+UVM_NO_RELNOTES \
		-incdir $(TOP_DIR) \
		-incdir $(AGENTS_DIR) \
		-incdir $(ENV_DIR) \
		-incdir $(SEQUENCE_DIR) \
		$(TOP_DIR)/interface.sv \
		$(TOP_DIR)/test_pkg.sv \
		$(RTL_DIR)/dut.sv \
		$(TOP_DIR)/top.sv

# ============================================
# Waveform viewer
# ============================================
wave:
	simvision -NOCOPYRIGHT -input $(SIM_DIR)/simvision.svcf &

# ============================================
# Coverage analysis
# ============================================
cover:
	imc -load $(COV_DIR)

# ============================================
# Clean simulation artifacts
# ============================================
clean:
	rm -rf cov_work $(WAVES_DB) $(XCELIUM_DIR) xrun.* *.log .simvision .bpad *.err *.history

# ============================================
# Help
# ============================================
help:
	@echo "========================================"
	@echo "  UVM Testbench Makefile (00.UVM)"
	@echo "========================================"
	@echo ""
	@echo "Prerequisites:"
	@echo "  - Xcelium (xrun) installed and configured"
	@echo "  - VManager (imc) for coverage analysis"
	@echo ""
	@echo "Usage Examples:"
	@echo "  make sim                          # Run simulation with default settings"
	@echo "  make sim SV_SEED=12345            # Run with specific seed"
	@echo "  make sim TESTNAME=my_test         # Run with specific test"
	@echo "  make sim UVM_VERBOSITY=UVM_HIGH   # Run with verbose output"
	@echo "  make wave                         # Open waveform viewer"
	@echo "  make cover                        # View coverage report"
	@echo "  make clean                        # Remove simulation artifacts"
	@echo ""
	@echo "Default values:"
	@echo "  SV_SEED:      $(SV_SEED)"
	@echo "  UVM_VERBOSITY: $(UVM_VERBOSITY)"
	@echo "  TESTNAME:     $(TESTNAME)"
	@echo ""

.PHONY: sim wave cover clean help

