class a_tr extends uvm_sequence_item;

  rand int a, a2, a3, a4, a5, a6, a7, a8;

  constraint a_positive { a > 0; }
  constraint a_small { a < 20; }

  constraint a2_positive { a2 > 0; }
  constraint a2_small { a2 < 20; }

  constraint a3_positive { a3 > 0; }
  constraint a3_small { a3 < 20; }

  constraint a4_positive { a4 > 0; }
  constraint a4_small { a4 < 20; }

  constraint a5_positive { a5 > 0; }
  constraint a5_small { a5 < 20; }

  constraint a6_positive { a6 > 0; }
  constraint a6_small { a6 < 20; }

  constraint a7_positive { a7 > 0; }
  constraint a7_small { a7 < 20; }

  constraint a8_positive { a8 > 0; }
  constraint a8_small { a8 < 20; }


  	`uvm_object_utils_begin(a_tr)  // needed for transaction recording
     	`uvm_field_int(a, UVM_ALL_ON | UVM_DEC)
	`uvm_field_int(a2, UVM_ALL_ON | UVM_DEC)
	`uvm_field_int(a3, UVM_ALL_ON | UVM_DEC)
	`uvm_field_int(a4, UVM_ALL_ON | UVM_DEC)
	`uvm_field_int(a5, UVM_ALL_ON | UVM_DEC)
	`uvm_field_int(a6, UVM_ALL_ON | UVM_DEC)
	`uvm_field_int(a7, UVM_ALL_ON | UVM_DEC)
	`uvm_field_int(a8, UVM_ALL_ON | UVM_DEC)
  	`uvm_object_utils_end

endclass
