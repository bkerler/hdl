// ***************************************************************************
// ***************************************************************************
// Copyright 2014 - 2017 (c) Analog Devices, Inc. All rights reserved.
//
// In this HDL repository, there are many different and unique modules, consisting
// of various HDL (Verilog or VHDL) components. The individual modules are
// developed independently, and may be accompanied by separate and unique license
// terms.
//
// The user should read each of these license terms, and understand the
// freedoms and responsibilities that he or she has by using this source/core.
//
// This core is distributed in the hope that it will be useful, but WITHOUT ANY
// WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
// A PARTICULAR PURPOSE.
//
// Redistribution and use of source or resulting binaries, with or without modification
// of this file, are permitted under one of the following two license terms:
//
//   1. The GNU General Public License version 2 as published by the
//      Free Software Foundation, which can be found in the top level directory
//      of this repository (LICENSE_GPL2), and also online at:
//      <https://www.gnu.org/licenses/old-licenses/gpl-2.0.html>
//
// OR
//
//   2. An ADI specific BSD license, which can be found in the top level directory
//      of this repository (LICENSE_ADIBSD), and also on-line at:
//      https://github.com/analogdevicesinc/hdl/blob/master/LICENSE_ADIBSD
//      This will allow to generate bit files and not release the source code,
//      as long as it attaches to an ADI device.
//
// ***************************************************************************
// ***************************************************************************

`timescale 1ns/100ps

module axi_ad7771_if (

  // device-interface

  input                   clk_in,
  input                   ready_in,
  input                   sync_in,
  input       [ 3:0]      data_in,

  // data path interface


  output                  adc_clk,
  output  reg             adc_valid_0,
  output  reg             adc_valid_1,
  output  reg             adc_valid_2,
  output  reg             adc_valid_3,
  output  reg             adc_valid_4,
  output  reg             adc_valid_5,
  output  reg             adc_valid_6,
  output  reg             adc_valid_7,

  output                 adc_valid_pp,

  output  reg [ 31:0]     adc_data_0,
  output  reg [ 31:0]     adc_data_1,
  output  reg [ 31:0]     adc_data_2,
  output  reg [ 31:0]     adc_data_3,
  output  reg [ 31:0]     adc_data_4,
  output  reg [ 31:0]     adc_data_5,
  output  reg [ 31:0]     adc_data_6,
  output  reg [ 31:0]     adc_data_7);

  // internal registers

  reg     [  1:0]   adc_status_8 = 'd0;
  reg     [  2:0]   adc_status_7 = 'd0;
  reg     [  2:0]   adc_status_6 = 'd0;
  reg     [  2:0]   adc_status_5 = 'd0;
  reg     [  2:0]   adc_status_4 = 'd0;
  reg     [  2:0]   adc_status_3 = 'd0;
  reg     [  2:0]   adc_status_2 = 'd0;
  reg     [  2:0]   adc_status_1 = 'd0;
  reg     [  2:0]   adc_status_0 = 'd0;
  reg     [  4:0]   adc_status = 'd0;
  reg     [ 63:0]   adc_crc_8 = 'd0;
  reg     [  7:0]   adc_crc_mismatch_int = 'd0;
  reg               adc_crc_valid = 'd0;
  reg     [  7:0]   adc_crc_data = 'd0;
  reg     [  7:0]   adc_crc_mismatch_8 = 'd0;
  reg               adc_valid_int = 'd0;
  reg     [ 31:0]   adc_data_int = 'd0;
  reg               adc_enable_int = 'd0;
  reg     [  7:0]   adc_ch_valid_d = 'd0;
  reg     [255:0]   adc_ch_data_d0 = 'd0;
  reg     [255:0]   adc_ch_data_d1 = 'd0;
  reg     [255:0]   adc_ch_data_d2 = 'd0;
  reg     [255:0]   adc_ch_data_d3 = 'd0;
  reg     [255:0]   adc_ch_data_d4 = 'd0;
  reg     [255:0]   adc_ch_data_d5 = 'd0;
  reg     [255:0]   adc_ch_data_d6 = 'd0;
  reg     [255:0]   adc_ch_data_d7 = 'd0;
  reg               adc_ch_valid_0 = 'd0;
  reg               adc_ch_valid_1 = 'd0;
  reg               adc_ch_valid_2 = 'd0;
  reg               adc_ch_valid_3 = 'd0;
  reg               adc_ch_valid_4 = 'd0;
  reg               adc_ch_valid_5 = 'd0;
  reg               adc_ch_valid_6 = 'd0;
  reg               adc_ch_valid_7 = 'd0;
  reg     [ 31:0]   adc_ch_data_0 = 'd0;
  reg     [ 31:0]   adc_ch_data_1 = 'd0;
  reg     [ 31:0]   adc_ch_data_2 = 'd0;
  reg     [ 31:0]   adc_ch_data_3 = 'd0;
  reg     [ 31:0]   adc_ch_data_4 = 'd0;
  reg     [ 31:0]   adc_ch_data_5 = 'd0;
  reg     [ 31:0]   adc_ch_data_6 = 'd0;
  reg     [ 31:0]   adc_ch_data_7 = 'd0;
  reg               adc_ch_valid = 'd0;
  reg     [255:0]   adc_ch_data = 'd0;
  reg     [  8:0]   adc_cnt_p = 'd0;
  reg               adc_valid_p = 'd0;
  reg     [255:0]   adc_data_p = 'd0;
  reg     [  7:0]   adc_data_d1 = 'd0;
  reg     [  7:0]   adc_data_d2 = 'd0;
  reg               adc_ready_d1 = 'd0;
  reg               adc_ready = 'd0;
  reg               adc_ready_d = 'd0;
  reg               adc_valid_pp_s = 'd0;

  // internal signals

  wire              adc_cnt_enable_s;
  wire    [  7:0]   adc_data_in_s;
  wire              adc_ready_in_s;
  wire    [ 35:0]   adc_status_clr_s;

assign adc_clk = clk_in;
assign adc_ready_in_s = ready_in;
assign adc_valid_pp = adc_valid_pp_s;
  // data & status

 
 
  always @(posedge adc_clk) begin
    
   
    if (adc_ch_valid_0 == 1'b1) begin
      adc_data_0 <= adc_ch_data_0;
    end
    if (adc_ch_valid_1 == 1'b1) begin
      adc_data_1 <= adc_ch_data_1;
    end
    if (adc_ch_valid_2 == 1'b1) begin
      adc_data_2 <= adc_ch_data_2;
    end
    if (adc_ch_valid_3 == 1'b1) begin
      adc_data_3 <= adc_ch_data_3;
    end
    if (adc_ch_valid_4 == 1'b1) begin
      adc_data_4 <= adc_ch_data_4;
    end
    if (adc_ch_valid_5 == 1'b1) begin
      adc_data_5 <= adc_ch_data_5;
    end
    if (adc_ch_valid_6 == 1'b1) begin
      adc_data_6 <= adc_ch_data_6;
    end
    if (adc_ch_valid_7 == 1'b1) begin
      adc_data_7 <= adc_ch_data_7;
    end

    adc_valid_0 <= adc_ch_valid_0;
    adc_valid_1 <= adc_ch_valid_1;
    adc_valid_2 <= adc_ch_valid_2;
    adc_valid_3 <= adc_ch_valid_3;
    adc_valid_4 <= adc_ch_valid_4;
    adc_valid_5 <= adc_ch_valid_5;
    adc_valid_6 <= adc_ch_valid_6;
    adc_valid_7 <= adc_ch_valid_7;
    
    adc_valid_pp_s <= adc_valid_0 | adc_valid_1 | adc_valid_2 | adc_valid_3 |
	            adc_valid_4 | adc_valid_5 | adc_valid_6 | adc_valid_7;
   
  end

  // data (interleaving)


  always @(posedge adc_clk) begin
    adc_ch_valid_d <= {adc_ch_valid_d[6:0], adc_ch_valid};
    adc_ch_data_d0[((32*0)+31):(32*0)] <= adc_ch_data[((32*0)+31):(32*0)];
    adc_ch_data_d0[((32*7)+31):(32*1)] <= adc_ch_data_d0[((32*6)+31):(32*0)];
    adc_ch_data_d1[((32*0)+31):(32*0)] <= adc_ch_data[((32*1)+31):(32*1)];
    adc_ch_data_d1[((32*7)+31):(32*1)] <= adc_ch_data_d1[((32*6)+31):(32*0)];
    adc_ch_data_d2[((32*0)+31):(32*0)] <= adc_ch_data[((32*2)+31):(32*2)];
    adc_ch_data_d2[((32*7)+31):(32*1)] <= adc_ch_data_d2[((32*6)+31):(32*0)];
    adc_ch_data_d3[((32*0)+31):(32*0)] <= adc_ch_data[((32*3)+31):(32*3)];
    adc_ch_data_d3[((32*7)+31):(32*1)] <= adc_ch_data_d3[((32*6)+31):(32*0)];
    adc_ch_data_d4[((32*0)+31):(32*0)] <= adc_ch_data[((32*4)+31):(32*4)];
    adc_ch_data_d4[((32*7)+31):(32*1)] <= adc_ch_data_d4[((32*6)+31):(32*0)];
    adc_ch_data_d5[((32*0)+31):(32*0)] <= adc_ch_data[((32*5)+31):(32*5)];
    adc_ch_data_d5[((32*7)+31):(32*1)] <= adc_ch_data_d5[((32*6)+31):(32*0)];
    adc_ch_data_d6[((32*0)+31):(32*0)] <= adc_ch_data[((32*6)+31):(32*6)];
    adc_ch_data_d6[((32*7)+31):(32*1)] <= adc_ch_data_d6[((32*6)+31):(32*0)];
    adc_ch_data_d7[((32*0)+31):(32*0)] <= adc_ch_data[((32*7)+31):(32*7)];
    adc_ch_data_d7[((32*7)+31):(32*1)] <= adc_ch_data_d7[((32*6)+31):(32*0)];
  end

  always @(posedge adc_clk) begin

    adc_ch_valid_0 <= adc_ch_valid_d[0];
    adc_ch_valid_1 <= adc_ch_valid_d[1];
    adc_ch_valid_2 <= adc_ch_valid_d[2];
    adc_ch_valid_3 <= adc_ch_valid_d[3];
    adc_ch_valid_4 <= adc_ch_valid_d[4];
    adc_ch_valid_5 <= adc_ch_valid_d[5];
    adc_ch_valid_6 <= adc_ch_valid_d[6];
    adc_ch_valid_7 <= adc_ch_valid_d[7];
    adc_ch_data_0 <= adc_ch_data_d0[((32*0)+31):(32*0)];
    adc_ch_data_1 <= adc_ch_data_d1[((32*0)+31):(32*0)];
    adc_ch_data_2 <= adc_ch_data_d2[((32*0)+31):(32*0)];
    adc_ch_data_3 <= adc_ch_data_d3[((32*0)+31):(32*0)];
    adc_ch_data_4 <= adc_ch_data_d4[((32*0)+31):(32*0)];
    adc_ch_data_5 <= adc_ch_data_d5[((32*0)+31):(32*0)];
    adc_ch_data_6 <= adc_ch_data_d6[((32*0)+31):(32*0)];
    adc_ch_data_7 <= adc_ch_data_d7[((32*0)+31):(32*0)];
  end

  always @(posedge adc_clk) begin
    adc_ch_valid <= adc_valid_p;
    if (adc_valid_p == 1'b1) begin
      adc_ch_data <= adc_data_p;
    end else begin
      adc_ch_data <= 256'd0;
    end
  end


  // data (common)

  assign adc_cnt_enable_s = (adc_cnt_p <= 9'h03f) ? 1'b1 : 1'b0;


  always @(posedge adc_clk) begin
    if (adc_ready_in_s == 1'b1) begin
      adc_cnt_p <= 9'h000;
    end else if (adc_cnt_enable_s == 1'b1) begin
      adc_cnt_p <= adc_cnt_p + 1'b1;
    end
    if (adc_cnt_p == 9'h01f || adc_cnt_p == 9'h03f) begin
      adc_valid_p <= 1'b1;
    end else begin
      adc_valid_p <= 1'b0;
    end
  end

  // data (individual lanes)

  genvar n;
  generate

  for (n = 0; n < 4; n = n + 1) begin: g_data

  always @(posedge adc_clk) begin
    if (adc_cnt_p[4:0] == 5'h00) begin
      adc_data_p[((32*n)+31):(32*n)] <= {31'd0, adc_data_in_s[n]};
    end else begin
      adc_data_p[((32*n)+31):(32*n)] <= {adc_data_p[((32*n)+30):(32*n)], adc_data_in_s[n]};
    end
  end

  assign adc_data_in_s[n] = data_in[n];

  end
  endgenerate

endmodule

// ***************************************************************************
// ***************************************************************************