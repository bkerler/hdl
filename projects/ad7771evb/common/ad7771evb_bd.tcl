
# ad7768 interface

create_bd_port -dir I adc_clk_in
create_bd_port -dir I adc_sync
create_bd_port -dir I adc_ready
create_bd_port -dir I -from 3 -to 0 adc_data_in

# instances

ad_ip_instance axi_dmac ad7771_dma
ad_ip_parameter ad7771_dma CONFIG.DMA_TYPE_SRC 2
ad_ip_parameter ad7771_dma CONFIG.DMA_TYPE_DEST 0
ad_ip_parameter ad7771_dma CONFIG.CYCLIC 0
ad_ip_parameter ad7771_dma CONFIG.SYNC_TRANSFER_START 1
ad_ip_parameter ad7771_dma CONFIG.AXI_SLICE_SRC 0
ad_ip_parameter ad7771_dma CONFIG.AXI_SLICE_DEST 0
ad_ip_parameter ad7771_dma CONFIG.DMA_2D_TRANSFER 0
ad_ip_parameter ad7771_dma CONFIG.DMA_DATA_WIDTH_SRC 256



# ps7-hp1

ad_ip_parameter sys_ps7 CONFIG.PCW_USE_S_AXI_HP1 1


# axi_ad7771

ad_ip_instance axi_ad7771 axi_ad7771_adc


# adc-path channel pack

ad_ip_instance util_cpack2 ad7771_adc_pack
ad_ip_parameter ad7771_adc_pack CONFIG.NUM_OF_CHANNELS 8
ad_ip_parameter ad7771_adc_pack CONFIG.SAMPLE_DATA_WIDTH 32

ad_connect axi_ad7771_adc/adc_clk ad7771_adc_pack/clk
ad_connect sys_rstgen/peripheral_reset ad7771_adc_pack/reset
ad_connect axi_ad7771_adc/adc_valid_pp ad7771_adc_pack/fifo_wr_en

ad_connect adc_data_in axi_ad7771_adc/data_in
ad_connect adc_ready axi_ad7771_adc/ready_in

for {set i 0} {$i < 8} {incr i} {
  ad_connect axi_ad7771_adc/adc_data_$i ad7771_adc_pack/fifo_wr_data_$i
  ad_connect axi_ad7771_adc/adc_enable_$i ad7771_adc_pack/enable_$i
}




# interconnects

ad_connect  sys_cpu_resetn ad7771_dma/m_dest_axi_aresetn
ad_connect  axi_ad7771_adc/adc_clk ad7771_dma/fifo_wr_clk
ad_connect  axi_ad7771_adc/adc_valid_pp ad7771_dma/fifo_wr_en

ad_connect  ad7771_adc_pack/packed_fifo_wr ad7771_dma/fifo_wr
ad_connect  ad7771_adc_pack/fifo_wr_overflow axi_ad7771_adc/adc_dovf
ad_connect  adc_clk_in axi_ad7771_adc/clk_in
ad_connect  sys_ps7/FCLK_CLK0 axi_ad7771_adc/s_axi_aclk


# interrupts

ad_cpu_interrupt ps-13 mb-13  ad7771_dma/irq


# cpu / memory interconnects

ad_cpu_interconnect 0x7C400000 ad7771_dma
ad_cpu_interconnect 0x7C420000 axi_ad7771_adc
 


ad_mem_hp1_interconnect sys_cpu_clk sys_ps7/S_AXI_HP1
ad_mem_hp1_interconnect sys_cpu_clk ad7771_dma/m_dest_axi

