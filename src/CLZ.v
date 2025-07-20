module CLZ(
input [31:0] datain,
output [31:0] dataout
);
assign dataout = datain[31] ? 0:(
                 datain[30] ? 1:(
                 datain[29] ? 2:(
                 datain[28] ? 3:(
                 datain[27] ? 4:(
                 datain[26] ? 5:(
                 datain[25] ? 6:(
                 datain[24] ? 7:(
                 datain[23] ? 8:(
                 datain[22] ? 9:(
                 datain[21] ? 10:(
                 datain[20] ? 11:(
                 datain[19] ? 12:(
                 datain[18] ? 13:(
                 datain[17] ? 14:(
                 datain[16] ? 15:(
                 datain[15] ? 16:(
                 datain[14] ? 17:(
                 datain[13] ? 18:(
                 datain[12] ? 19:(
                 datain[11] ? 20:(
                 datain[10] ? 21:(
                 datain[9] ? 22:(
                 datain[8] ? 23:(
                 datain[7] ? 24:(
                 datain[6] ? 25:(
                 datain[5] ? 26:(
                 datain[4] ? 27:(
                 datain[3] ? 28:(
                 datain[2] ? 29:(
                 datain[1] ? 30:(
                 datain[0] ? 31:32
                 )))))))))))))))))))))))))))))));

endmodule