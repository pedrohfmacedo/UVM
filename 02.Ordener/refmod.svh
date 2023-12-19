class refmod extends uvm_component;
   `uvm_component_utils(refmod)

   uvm_get_port #(a_tr) in; 
   uvm_blocking_put_port #(a_tr) out; 

   function new(string name, uvm_component parent=null);
      super.new(name,parent);
      in  = new("in",  this);
      out = new("out", this);
   endfunction : new

   task sorted_bubble(logic [7:0] v [7:0], a_tr tr_in);
      logic [7:0] vt;
      v[0] = tr_in.a;
      v[1] = tr_in.a2;
      v[2] = tr_in.a3;
      v[3] = tr_in.a4;
      v[4] = tr_in.a5;
      v[5] = tr_in.a6;
      v[6] = tr_in.a7;
      v[7] = tr_in.a8;

      for (int i = 1; i < 8; i++) begin
         if (v[i] > v[i-1]) begin
            vt = v[i];
            v[i] = v[i-1];
            v[i-1] = vt;
         end
      end

   endtask

   task run_phase(uvm_phase phase);
      a_tr tr_in, tr_out;
      logic [7:0] v [7:0];
      logic [7:0] vt;

      forever begin
         in.get(tr_in);
         v[0] = tr_in.a;
         v[1] = tr_in.a2;
         v[2] = tr_in.a3;
         v[3] = tr_in.a4;
         v[4] = tr_in.a5;
         v[5] = tr_in.a6;
         v[6] = tr_in.a7;
         v[7] = tr_in.a8;

         for (int i = 0; i < 8; i++) begin
            for (int j = i; j < 8; j++) begin
               if (v[i] > v[j]) begin
                  vt = v[i];
                  v[i] = v[j];
                  v[j] = vt;
               end
            end
         end

         #10;
         `bvm_end_tr(tr_in);

         tr_out = a_tr::type_id::create("tr_out", this);
         tr_out.a  = v[0];
         tr_out.a2 = v[1];
         tr_out.a3 = v[2];
         tr_out.a4 = v[3];
         tr_out.a5 = v[4];
         tr_out.a6 = v[5];
         tr_out.a7 = v[6];
         tr_out.a8 = v[7];
         `bvm_begin_tr(tr_out)
         #10;
         out.put(tr_out);
      end
   endtask

endclass

