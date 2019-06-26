// DESCRIPTION: Verilator: Systemverilog example module
// with interface to switch buttons, LEDs, LCD and register display

parameter NINSTR_BITS = 32;
parameter NBITS_TOP = 8, NREGS_TOP = 32, NBITS_LCD = 64;
module top(input  logic clk_2,
           input  logic [NBITS_TOP-1:0] SWI,
           output logic [NBITS_TOP-1:0] LED,
           output logic [NBITS_TOP-1:0] SEG,
           output logic [NBITS_LCD-1:0] lcd_a, lcd_b,
           output logic [NINSTR_BITS-1:0] lcd_instruction,
           output logic [NBITS_TOP-1:0] lcd_registrador [0:NREGS_TOP-1],
           output logic [NBITS_TOP-1:0] lcd_pc, lcd_SrcA, lcd_SrcB,
             lcd_ALUResult, lcd_Result, lcd_WriteData, lcd_ReadData, 
           output logic lcd_MemWrite, lcd_Branch, lcd_MemtoReg, lcd_RegWrite);

  // always_comb begin
  //   LED <= SWI | clk_2;
  //   SEG <= SWI;
  //   lcd_WriteData <= SWI;
  //   lcd_pc <= 'h12;
  //   lcd_instruction <= 'h34567890;
  //   lcd_SrcA <= 'hab;
  //   lcd_SrcB <= 'hcd;
  //   lcd_ALUResult <= 'hef;
  //   lcd_Result <= 'h11;
  //   lcd_ReadData <= 'h33;
  //   lcd_MemWrite <= SWI[0];
  //   lcd_Branch <= SWI[1];
  //   lcd_MemtoReg <= SWI[2];
  //   lcd_RegWrite <= SWI[3];
  //   for(int i=0; i<NREGS_TOP; i++) lcd_registrador[i] <= i+i*16;
  //   lcd_a <= {56'h1234567890ABCD, SWI};
  //   lcd_b <= {SWI, 56'hFEDCBA09876543};
  // end


// Meche a partir daqui.

// Treinando

// logic signed [3:0] c;
// always_comb c <= SWI[3:0];

// always_comb begin 
//   unique case(SWI[3:0])
//     0: SEG[7:0] = 8'b00111111;
//     1: SEG[7:0] = 8'b00000110;
//   endcase
// end



// Treinando Máquina de Estados

// parameter state_1 = 0, state_2 = 1;

// logic reset;
// logic [1:0] cont;
// logic [1:0] estado_atual;

// always_comb begin
//   reset <= SWI[0];
// end

// always_ff@(posedge clk_2 or posedge reset) begin
//   if(reset) begin
//     cont <= 0;
//     estado_atual <= state_1;
//   end
//   else begin
//     unique case(estado_atual)
//       state_1: begin
//         if(cont == 3) begin
//           estado_atual <= state_2;
//           cont <= 0;
//         end
//         else cont <= cont + 1;
//       end

//       state_2: begin
//         if(cont == 2) begin
//           estado_atual <= state_1;
//           cont <= 0;
//         end 
//         else cont <= cont + 1;
//       end
//     endcase
//   end
// end

// always_comb begin
//   LED[7] <= clk_2;
//   unique case(estado_atual)
//     state_1: begin
//       LED[0] <= 1;
//       LED[1] <= 0;
//     end

//     state_2: begin
//       LED[1] <= 1;
//       LED[0] <= 0;
//     end
//   endcase
// end
                      
//                            ALTERANDO A VELOCIDADE DO CLOCK

// logic clk_1; //clock de 1hz
// logic clk_3; //clock 4 vezes mais lento que o original

// always_ff@(posedge clk_2)begin
//   clk_1 <= ~clk_1;
// end

// always_ff@(posedge clk_1) begin
//   clk_3 <= ~clk_3;
// end

// always_comb begin
//   SEG[0] <= clk_2;  //clock original, mais rápido
//   SEG[6] <= clk_1;  //clock 2x mais lento
//   SEG[3] <= clk_3;  //clock 4x mais lento
// end


//                          ATIVIDADE  LIMPADOR DE PARABRISA

enum logic [2:0] {off, low, beforeLow, high, beforeHigh} state;

logic reset;
logic[5:0] chuva;
logic[1:0] limpador;
logic[1:0] cont;
logic error;

always_comb begin
  SEG[7] <= clk_2;
  chuva <= SWI[5:0];
  LED[1:0] <= limpador;
  LED[7:6] <= cont;
  reset <= SWI[6];
end

always_ff@(posedge clk_2 or posedge reset) begin
  if(reset) begin
    limpador <= 0;
    state <= off; //volta para o estado inicial
  end
  else begin
    unique case(state)
      off: if(chuva > 5) begin //estado desligado e mais de 5 gotas
        cont <= 1;
        state <= beforeHigh;
      end
      else 
        if(chuva <= 5 && chuva > 3)begin
          cont <= 1;
          state <= beforeLow;
        end
        else cont <= 0;

      beforeLow: if(chuva <= 5 && chuva > 3 && cont < 2)begin
        cont <= cont + 1;
        end
        else 
          if(cont == 2 && chuva <= 5 && chuva > 3) begin
            state <= low;
            limpador <= 1;
            cont <= 0;
          end
          else
            if(chuva > 5)begin
              cont <= 1;
              state <= beforeHigh;
            end
            else begin
              cont <= 0;
              state <= off;
            end

      low:if(chuva > 5)begin
        cont <= cont + 1;
        state <= beforeHigh;
        end
        else
          if(chuva < 2) begin
            cont <= 0;
            state <= off;
            limpador <= 0;
          end
          else cont <= 0;
      
      beforeHigh: if(chuva > 5) begin
        state <= high;
        limpador <= 3;
        cont <= 0;
        end
        else begin
          cont <= 0;
          if(limpador == 0)begin
            state <= off;
          end
          else begin
            state <= low;
          end
        end
      
      high: if(chuva < 4)begin
        state <= low;
        limpador <= 1;
        cont <= 0;
      end
      else cont <= 0;

    endcase
  end
end

endmodule