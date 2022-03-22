// ***************************************************************************
// ***************************************************************************
// Copyright 2019 - 2020 (c) Analog Devices, Inc. All rights reserved.
//
// In this HDL repository, there are many different and unique modules, consisting
// of various HDL (Verilog or VHDL) components. The individual modules are
// developed independently, and may be accompanied by separate and unique license
// terms.
//
// The user should read each of these license terms, and understand the
// freedoms and responsabilities that he or she has by using this source/core.
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

`timescale 1ns / 1ps

module axi_ad7768 #(
  parameter   ID = 0)(

  input           adc_dovf,
  input           clk_in,
  input           ready_in,
  input   [ 3:0]  data_in,    

  output          adc_enable_0,
  output          adc_enable_1,
  output          adc_enable_2,
  output          adc_enable_3,
  output          adc_enable_4,
  output          adc_enable_5,
  output          adc_enable_6,
  output          adc_enable_7,

  output  [31:0]  adc_data_0,
  output  [31:0]  adc_data_1,
  output  [31:0]  adc_data_2,
  output  [31:0]  adc_data_3,
  output  [31:0]  adc_data_4,
  output  [31:0]  adc_data_5,
  output  [31:0]  adc_data_6,
  output  [31:0]  adc_data_7,
  output          adc_clk,
  output          adc_valid,
  output          adc_valid_pp,

  



  input           s_axi_aclk,
  input           s_axi_aresetn,
  input           s_axi_awvalid,
  input   [15:0]  s_axi_awaddr,
  input   [ 2:0]  s_axi_awprot,
  output          s_axi_awready,
  input           s_axi_wvalid,
  input   [31:0]  s_axi_wdata,
  input   [ 3:0]  s_axi_wstrb,
  output          s_axi_wready,
  output          s_axi_bvalid,
  output  [ 1:0]  s_axi_bresp,
  input           s_axi_bready,
  input           s_axi_arvalid,
  input   [15:0]  s_axi_araddr,
  input   [ 2:0]  s_axi_arprot,
  output          s_axi_arready,
  output          s_axi_rvalid,
  output  [ 1:0]  s_axi_rresp,
  output  [31:0]  s_axi_rdata,
  input           s_axi_rready);

  wire          adc_clk_s;
  wire          valid_pp_s;
  wire  [35:0]  up_status_clr_s;
  wire  [35:0]  up_status_s;
  
  
  
  
  
  
  assign adc_clk = adc_clk_s;
  assign up_status_clr_s [32:0] = up_status_clr;
  assign up_status_clr_s [35:33] = 'h0;
  assign up_status = up_status_s [32:0];

axi_generic_adc #(
  .NUM_OF_CHANNELS(8),
  .ID(ID))

i_axi_generic_adc (
  .s_axi_aclk(s_axi_aclk),
  .s_axi_aresetn(s_axi_aresetn),
  .s_axi_awvalid(s_axi_awvalid),
  .s_axi_awaddr(s_axi_awaddr),
  .s_axi_awready(s_axi_awready),
  .s_axi_wvalid(s_axi_wvalid),
  .s_axi_wdata(s_axi_wdata),
  .s_axi_wstrb(s_axi_wstrb),
  .s_axi_wready(s_axi_wready),
  .s_axi_bvalid(s_axi_bvalid),
  .s_axi_bresp(s_axi_bresp),
  .s_axi_bready(s_axi_bready),
  .s_axi_arvalid(s_axi_arvalid),
  .s_axi_araddr(s_axi_araddr),
  .s_axi_arready(s_axi_arready),
  .s_axi_rvalid(s_axi_rvalid),
  .s_axi_rresp(s_axi_rresp),
  .s_axi_rdata(s_axi_rdata),
  .s_axi_rready(s_axi_rready),
  .s_axi_awprot(s_axi_awprot),
  .s_axi_arprot(s_axi_arprot),
  .adc_clk(adc_clk_s),
  .adc_enable({adc_enable_0,adc_enable_1,adc_enable_2,adc_enable_3,adc_enable_4,adc_enable_5,adc_enable_6,adc_enable_7}),
  .adc_dovf(adc_dovf));

ad7768_if i_ad7768_if (
  .clk_in (clk_in),
  .ready_in (ready_in),
  .data_in (data_in),
  .adc_clk (adc_clk_s),
  .adc_valid_pp (adc_valid_pp),
  .adc_sync (adc_sync),
  .adc_data (adc_data_p),
  .adc_data_0 (adc_data_0),
  .adc_data_1 (adc_data_1),
  .adc_data_2 (adc_data_2),
  .adc_data_3 (adc_data_3),
  .adc_data_4 (adc_data_4),
  .adc_data_5 (adc_data_5),
  .adc_data_6 (adc_data_6),
  .adc_data_7 (adc_data_7));

endmodule
