//
// Generated by Bluespec Compiler (build 7d0b6cf)
//
// On Thu Mar 18 16:36:47 IST 2021
//
//
// Ports:
// Name                         I/O  size props
// RDY_in_put                     O     1 const
// out_get                        O     8 reg
// RDY_out_get                    O     1
// RDY_configure                  O     1 const
// interrupt                      O     1
// RDY_interrupt                  O     1 const
// CLK                            I     1 clock
// RST_N                          I     1 reset
// in_put                         I     8
// configure_address              I     8
// configure_data                 I     8 reg
// EN_in_put                      I     1
// EN_configure                   I     1
// EN_out_get                     I     1
//
// Combinational paths from inputs to outputs:
//   EN_in_put -> interrupt
//
//

`ifdef BSV_ASSIGNMENT_DELAY
`else
  `define BSV_ASSIGNMENT_DELAY
`endif

`ifdef BSV_POSITIVE_RESET
  `define BSV_RESET_VALUE 1'b1
  `define BSV_RESET_EDGE posedge
`else
  `define BSV_RESET_VALUE 1'b0
  `define BSV_RESET_EDGE negedge
`endif

module sumof5(CLK,
	      RST_N,

	      in_put,
	      EN_in_put,
	      RDY_in_put,

	      EN_out_get,
	      out_get,
	      RDY_out_get,

	      configure_address,
	      configure_data,
	      EN_configure,
	      RDY_configure,

	      interrupt,
	      RDY_interrupt);
  input  CLK;
  input  RST_N;

  // action method in_put
  input  [7 : 0] in_put;
  input  EN_in_put;
  output RDY_in_put;

  // actionvalue method out_get
  input  EN_out_get;
  output [7 : 0] out_get;
  output RDY_out_get;

  // action method configure
  input  [7 : 0] configure_address;
  input  [7 : 0] configure_data;
  input  EN_configure;
  output RDY_configure;

  // value method interrupt
  output interrupt;
  output RDY_interrupt;

  // signals for module outputs
  wire [7 : 0] out_get;
  wire RDY_configure, RDY_in_put, RDY_interrupt, RDY_out_get, interrupt;

  // register count
  reg [7 : 0] count;
  wire [7 : 0] count$D_IN;
  wire count$EN;

  // register length
  reg [7 : 0] length;
  wire [7 : 0] length$D_IN;
  wire length$EN;

  // register start
  reg start;
  wire start$D_IN, start$EN;

  // register sum
  reg [7 : 0] sum;
  wire [7 : 0] sum$D_IN;
  wire sum$EN;

  // rule scheduling signals
  wire CAN_FIRE_RL_setDone,
       CAN_FIRE_RL_so5,
       CAN_FIRE_configure,
       CAN_FIRE_in_put,
       CAN_FIRE_out_get,
       WILL_FIRE_RL_setDone,
       WILL_FIRE_RL_so5,
       WILL_FIRE_configure,
       WILL_FIRE_in_put,
       WILL_FIRE_out_get;

  // inputs to muxes for submodule ports
  wire [7 : 0] MUX_count$write_1__VAL_3, MUX_sum$write_1__VAL_2;
  wire MUX_count$write_1__SEL_1;

  // remaining internal signals
  wire [7 : 0] y__h346;

  // action method in_put
  assign RDY_in_put = 1'd1 ;
  assign CAN_FIRE_in_put = 1'd1 ;
  assign WILL_FIRE_in_put = EN_in_put ;

  // actionvalue method out_get
  assign out_get = sum ;
  assign RDY_out_get = CAN_FIRE_out_get && !WILL_FIRE_RL_so5 ;
  assign CAN_FIRE_out_get = CAN_FIRE_RL_setDone ;
  assign WILL_FIRE_out_get = EN_out_get ;

  // action method configure
  assign RDY_configure = 1'd1 ;
  assign CAN_FIRE_configure = 1'd1 ;
  assign WILL_FIRE_configure = EN_configure ;

  // value method interrupt
  assign interrupt = EN_in_put && !start ;
  assign RDY_interrupt = 1'd1 ;

  // rule RL_so5
  assign CAN_FIRE_RL_so5 = start && count < length ;
  assign WILL_FIRE_RL_so5 = CAN_FIRE_RL_so5 ;

  // rule RL_setDone
  assign CAN_FIRE_RL_setDone = count == length ;
  assign WILL_FIRE_RL_setDone = CAN_FIRE_RL_setDone ;

  // inputs to muxes for submodule ports
  assign MUX_count$write_1__SEL_1 =
	     EN_configure && configure_address == 8'd1 ;
  assign MUX_count$write_1__VAL_3 = count + 8'd1 ;
  assign MUX_sum$write_1__VAL_2 = sum + y__h346 ;

  // register count
  assign count$D_IN =
	     (MUX_count$write_1__SEL_1 || EN_out_get) ?
	       8'd0 :
	       MUX_count$write_1__VAL_3 ;
  assign count$EN =
	     WILL_FIRE_RL_so5 && EN_in_put ||
	     EN_configure && configure_address == 8'd1 ||
	     EN_out_get ;

  // register length
  assign length$D_IN = configure_data ;
  assign length$EN = EN_configure && configure_address == 8'd0 ;

  // register start
  assign start$D_IN = MUX_count$write_1__SEL_1 ;
  assign start$EN =
	     EN_configure && configure_address == 8'd1 ||
	     WILL_FIRE_RL_setDone ;

  // register sum
  assign sum$D_IN = MUX_count$write_1__SEL_1 ? 8'd0 : MUX_sum$write_1__VAL_2 ;
  assign sum$EN =
	     WILL_FIRE_RL_so5 && EN_in_put ||
	     EN_configure && configure_address == 8'd1 ;

  // remaining internal signals
  assign y__h346 = EN_in_put ? in_put : 8'd0 ;

  // handling of inlined registers

  always@(posedge CLK or `BSV_RESET_EDGE RST_N)
  if (RST_N == `BSV_RESET_VALUE)
    begin
      count <= `BSV_ASSIGNMENT_DELAY 8'd0;
      length <= `BSV_ASSIGNMENT_DELAY 8'h0F;
      start <= `BSV_ASSIGNMENT_DELAY 1'd0;
      sum <= `BSV_ASSIGNMENT_DELAY 8'd0;
    end
  else
    begin
      if (count$EN) count <= `BSV_ASSIGNMENT_DELAY count$D_IN;
      if (length$EN) length <= `BSV_ASSIGNMENT_DELAY length$D_IN;
      if (start$EN) start <= `BSV_ASSIGNMENT_DELAY start$D_IN;
      if (sum$EN) sum <= `BSV_ASSIGNMENT_DELAY sum$D_IN;
    end

  // synopsys translate_off
  `ifdef BSV_NO_INITIAL_BLOCKS
  `else // not BSV_NO_INITIAL_BLOCKS
  initial
  begin
    count = 8'hAA;
    length = 8'hAA;
    start = 1'h0;
    sum = 8'hAA;
  end
  `endif // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on
endmodule  // sumof5

