

module and2 (
    input logic a, b,
    output logic y);

    assign y = a & b;

endmodule


module or2 (
    input logic a, b,
    output logic y);

    assign y = a | b;

endmodule


module buffer (
    input logic a,
    output logic y);

    assign y = a;
endmodule


module inv (
    input logic a,
    output logic y);

    assign y = ~a;

endmodule


module nand2 (
    input logic a, b,
    output logic y);

    logic and_result;

    and2 and_gate (a, b, and_result);

    inv inv_gate (and_result, y);

endmodule


module nor2 (
    input logic a, b,
    output logic y);

    logic or_result;

    or2 or_gate (a, b, or_result);

    inv inv_gate (or_result, y);

endmodule


module xor2 (
    input logic a, b,
    output logic y);

    logic a_inv,b_inv,and1, and2, or_result;

    inv inv_gate_a (a, a_inv);
    inv inv_gate_b (b, b_inv);

    and2 and_gate1 (a, b_inv, and1);
    and2 and_gate2 (a_inv, b, and2);

    or2 or_gate (and1, and2, y);

endmodule


module xnor2 (
    input logic a, b,
    output logic y);

    logic xor_result;
    
    xor2 xor_gate (a, b, xor_result);

    inv inv_gate (xor_result, y);

endmodule


module shift_right_one (
    input logic [3:0] a,
    output logic [3:0] y
);

    assign y = {1'b0, a[3:1]};

endmodule


module mux_2to1 (
    input logic [3:0] a, b,
    input logic c,
    output logic [3:0] y);

    assign y = c ? b : a;

endmodule


module mux_8to1 (
    input logic [7:0] data_0, data_1, data_2, data_3, 
                      data_4, data_5, data_6, data_7,
    input logic [2:0] control,
    output logic [7:0] final_output);

    assign final_output = (control == 3'b000) ? data_0 :
                   (control == 3'b001) ? data_1 :
                   (control == 3'b010) ? data_2 :
                   (control == 3'b011) ? data_3 :
                   (control == 3'b100) ? data_4 :
                   (control == 3'b101) ? data_5 :
                   (control == 3'b110) ? data_6 :
                                        data_7;

endmodule


module half_adder (
    input logic a, b,
    output logic sum, carry);

    xor2 xor_gate (a, b, sum);

    and2 and_gate1 (a, b, carry);

endmodule


module full_adder (
    input logic a, b, cin,
    output logic sum, cout);

    logic sum_ab, carry_ab, carry_bc;

    half_adder ha1 (a, b, sum_ab, carry_ab);
    half_adder ha2 (sum_ab, cin, sum, carry_bc);

    or2 or_gate (carry_ab, carry_bc, cout);

endmodule


module add_sub_4_bit (
    input logic [3:0] a, b, input logic c,
    output logic [3:0] sum, output logic carry);

    logic xor_b0,xor_b1,xor_b2,xor_b3, carry_1, carry_2, carry_3;

    xor2 xor_gate_1 (c, b[0], xor_b0);
    xor2 xor_gate_2 (c, b[1], xor_b1);
    xor2 xor_gate_3 (c, b[2], xor_b2);
    xor2 xor_gate_4 (c, b[3], xor_b3);

    full_adder fa0 (a[0], xor_b0, c, sum[0], carry_1);
    full_adder fa1 (a[1], xor_b1, carry_1, sum[1], carry_2);
    full_adder fa2 (a[2], xor_b2, carry_2, sum[2], carry_3);
    full_adder fa3 (a[3], xor_b3, carry_3, sum[3], carry);

endmodule


module or_operation (
    input logic [3:0] a, b,
    output logic [7:0] y);

    or2 or_gate_0 (a[0], b[0], y[0]);
    or2 or_gate_1 (a[1], b[1], y[1]);
    or2 or_gate_2 (a[2], b[2], y[2]);
    or2 or_gate_3 (a[3], b[3], y[3]);

    buffer b1 (1'b0, y[4]);
    buffer b2 (1'b0, y[5]);
    buffer b3 (1'b0, y[6]);
    buffer b4 (1'b0, y[7]);

endmodule


module nand_operation (
    input logic [3:0] a, b,
    output logic [7:0] y);

    nand2 nand_gate_0 (a[0], b[0], y[0]);
    nand2 nand_gate_1 (a[1], b[1], y[1]);
    nand2 nand_gate_2 (a[2], b[2], y[2]);
    nand2 nand_gate_3 (a[3], b[3], y[3]);

    buffer b1 (1'b0, y[4]);
    buffer b2 (1'b0, y[5]);
    buffer b3 (1'b0, y[6]);
    buffer b4 (1'b0, y[7]);

endmodule


module xor_operation (
    input logic [3:0] a, b,
    output logic [7:0] y);

    xor2 xor_gate_0 (a[0], b[0], y[0]);
    xor2 xor_gate_1 (a[1], b[1], y[1]);
    xor2 xor_gate_2 (a[2], b[2], y[2]);
    xor2 xor_gate_3 (a[3], b[3], y[3]);

    buffer b1 (1'b0, y[4]);
    buffer b2 (1'b0, y[5]);
    buffer b3 (1'b0, y[6]);
    buffer b4 (1'b0, y[7]);

endmodule


module multiplication_operation (
    input logic [3:0] a, b,
    output logic [7:0] y);

    logic [3:0]and_1, and_2, and_3, and_4, sum_1,sum_1_af, sum_2, sum_2_af, sum_3;
    logic carry_1, carry_2, carry_3;

    and2 level_0_and_0 (a[0], b[0] , y[0]);
    and2 level_0_and_1 (a[0], b[1] , and_1[0]);
    and2 level_0_and_2 (a[0], b[2] , and_1[1]);
    and2 level_0_and_3 (a[0], b[3] , and_1[2]);
    
    buffer b1 (1'b0, and_1[3]);

    and2 level_1_and_0 (a[1], b[0] , and_2[0]);
    and2 level_1_and_1 (a[1], b[1] , and_2[1]);
    and2 level_1_and_2 (a[1], b[2] , and_2[2]);
    and2 level_1_and_3 (a[1], b[3] , and_2[3]);


    add_sub_4_bit first_adder (and_1, and_2, 1'b0, sum_1, carry_1);

    buffer b2 (sum_1[0], y[1]);
    
    and2 level_2_and_0 (a[2], b[0] , and_3[0]);
    and2 level_2_and_1 (a[2], b[1] , and_3[1]);
    and2 level_2_and_2 (a[2], b[2] , and_3[2]);
    and2 level_2_and_3 (a[2], b[3] , and_3[3]);


    add_sub_4_bit second_adder ({carry_1,sum_1[3:1]}, and_3, 1'b0, sum_2, carry_2);

    buffer b3 (sum_2[0], y[2]);
    
    and2 level_3_and_0 (a[3], b[0] , and_4[0]);
    and2 level_3_and_1 (a[3], b[1] , and_4[1]);
    and2 level_3_and_2 (a[3], b[2] , and_4[2]);
    and2 level_3_and_3 (a[3], b[3] , and_4[3]);


    add_sub_4_bit third_adder ({carry_2,sum_2[3:1]}, and_4, 1'b0, sum_3, carry_3);

    buffer b4 (sum_3[0], y[3]);
    buffer b5 (sum_3[1], y[4]);
    buffer b6 (sum_3[2], y[5]);
    buffer b7 (sum_3[3], y[6]);
    buffer b8 (carry_3, y[7]);
 
endmodule


module add_inc_sub_operation (
    input logic [3:0] a, b, input logic inc, sub,
    output logic [7:0] sum);

    logic [3:0] input_1, input_2;
    logic carry;

    buffer b1 (a[0], input_1[0]);
    buffer b2 (a[1], input_1[1]);
    buffer b3 (a[2], input_1[2]);
    buffer b4 (a[3], input_1[3]);

    mux_2to1 mux (b, 4'b0001, inc, input_2);

    add_sub_4_bit all_in_one (input_1, input_2, sub, sum[3:0], carry);

    or2 or5 (carry, sub, sum[4]);
    buffer b6 (sub, sum[5]);
    buffer b7 (sub, sum[6]);
    buffer b8 (sub, sum[7]);

endmodule


module shift_right_operation (
    input logic [3:0] a,
    output logic [7:0] y);

    shift_right_one opp (a, y[3:0]);

    buffer b1 (1'b0, y[4]);
    buffer b2 (1'b0, y[5]);
    buffer b3 (1'b0, y[6]);
    buffer b4 (1'b0, y[7]);

endmodule


module ALU (
    input logic [3:0] a, b, input logic [2:0] key,
    output logic [7:0] answer);

    logic [7:0] op_1, op_2, op_3, op_4, op_5, op_6;

    or_operation opp_1 (a, b, op_1);
    nand_operation opp_2 (a, b, op_2);
    xor_operation opp_3 (a, b, op_3);
    multiplication_operation opp_4 (a, b, op_4);
    add_inc_sub_operation opp_5 (a, b, key[0], key[1], op_5);
    shift_right_operation opp_6 (a, op_6);

    mux_8to1 mux_1 (op_1, op_2, op_3, op_4, op_5, op_5, op_5, op_6, key, answer);


endmodule


module testbench_1 ();

    logic [3:0] a, b;
    logic [7:0] y;
    logic [2:0] key;
    ALU all (a, b ,key, y);

    initial begin
        a[0] = 0;
        a[1] = 1;
        a[2] = 1;
        a[3] = 0;
        b[0] = 1;
        b[1] = 1;
        b[2] = 0;
        b[3] = 1;
        key[0] = 0;
        key[1] = 0;
        key[2] = 0; #10

        key[0] = 1;
        key[1] = 0;
        key[2] = 0; #10;

        key[0] = 0;
        key[1] = 1;
        key[2] = 0; #10;

        key[0] = 1;
        key[1] = 1;
        key[2] = 0; #10;

        key[0] = 0;
        key[1] = 0;
        key[2] = 1; #10;

        key[0] = 1;
        key[1] = 0;
        key[2] = 1; #10;

        key[0] = 0;
        key[1] = 1;
        key[2] = 1; #10;

        key[0] = 1;
        key[1] = 1;
        key[2] = 1; #10;
    end

endmodule




module testbench_2 ();

    logic [3:0] a, b;
    logic [7:0] y;
    multiplication_operation all (a, b , y);

    initial begin
        a[0] = 1;
        a[1] = 1;
        a[2] = 0;
        a[3] = 1;
        b[0] = 1;
        b[1] = 1;
        b[2] = 1;
        b[3] = 0;#10;
    end
endmodule


module testbench_3 ();

    logic [3:0] a, b;
    logic [7:0] y;
    nand_operation all (a, b , y);

    initial begin
        a[0] = 1;
        a[1] = 1;
        a[2] = 0;
        a[3] = 1;
        b[0] = 1;
        b[1] = 0;
        b[2] = 1;
        b[3] = 0;#10;
    end

endmodule