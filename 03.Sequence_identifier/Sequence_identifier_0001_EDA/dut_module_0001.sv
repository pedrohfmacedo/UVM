module det_0001 ( input clk,
                  input rstn,
                  input in,
                  output out );
  
  //states
  parameter [2:0] S0 = 3'b000;
  parameter [2:0] S1 = 3'b001;
  parameter [2:0] S2 = 3'b010;
  parameter [2:0] S3 = 3'b011;
  parameter [2:0] S4 = 3'b100;
  
  reg [2:0] atual_estado, proximo_estado;

//logic next state
always_comb
	begin
      case(atual_estado)
        S0: begin
            if (in) proximo_estado = S0;
            else proximo_estado = S1;
        end
        S1: begin
            if (in) proximo_estado = S0;
            else proximo_estado = S2;
        end
        S2: begin
            if (in) proximo_estado = S0;
            else proximo_estado = S3;
        end
        S3: begin
          if (in) proximo_estado = S4;
            else proximo_estado = S0;
        end
        S4: begin
            if (in) proximo_estado = S0;
            else proximo_estado = S1;
        end
        default: proximo_estado = S0;
    endcase
end

  // logic register level 
  always @ (posedge clk) begin
    if (!rstn)
      	atual_estado <= S0;
     else 
     	atual_estado <= proximo_estado;
  end
   //logic out
  assign out = (atual_estado == S4);
  //assign out = (atual_estado == S4) ? 1 : 0;
endmodule
