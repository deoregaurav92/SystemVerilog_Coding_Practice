///////////////////////////////////////////////////////////////////////////
// (c) Copyright 2013 Cadence Design Systems, Inc. All Rights Reserved.
//
// File name   : flipflop_test.sv
// Title       : Flipflop Testbench Module
// Project     : SystemVerilog Training
// Created     : 2013-4-8
// Description : Defines the Flipflop testbench module
// Notes       :
// 
///////////////////////////////////////////////////////////////////////////

module testflop ();
timeunit 1ns;
timeprecision 100ps;

logic reset;
logic [7:0] qin,qout;

// ---- clock generator code begin------
`define PERIOD 10
logic clk = 1'b1;

always
    #(`PERIOD/2)clk = ~clk;

// ---- clock generator code end------


flipflop DUV(.*);
int i;

//Adding a clocking block
default clocking cb @(posedge clk);
	default input #1step output #4ns;
	input qout;
	output reset;
	output qin;
endclocking

//Adding stimulus to drive clocking block
initial
begin
		cb.reset <= 1'b1;
	##3 cb.reset <= 1'b0;
	for(i = 0; i <= 7; i++)
		##1 cb.qin <= i;
	$finish;
end
endmodule
