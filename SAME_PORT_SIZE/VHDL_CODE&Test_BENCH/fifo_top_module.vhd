----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/22/2020 06:30:10 AM
-- Design Name: 
-- Module Name: fifo_top_module - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fifo_top_module is
    Port ( wdata : in STD_LOGIC_VECTOR (7 downto 0);
           winc : in STD_LOGIC;
           wclk : in STD_LOGIC;
           rclk : in STD_LOGIC;
           wrst : in STD_LOGIC;
           rrst : in STD_LOGIC;
           rinc : in STD_LOGIC;
           rdata : out STD_LOGIC_VECTOR (7 downto 0);
           wfull : out STD_LOGIC;
           rempty : out STD_LOGIC);
end fifo_top_module;

architecture Behavioral of fifo_top_module is

component mem_fifo 
    Port ( wdata : in STD_LOGIC_VECTOR (7 downto 0);
           waddr : in STD_LOGIC_VECTOR (3 downto 0);
           raddr : in STD_LOGIC_VECTOR (3 downto 0);
           wclk : in STD_LOGIC;
           rclk : in STD_LOGIC;
           wclken : in STD_LOGIC;
           wfull : in STD_LOGIC;
           rdata : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component radrs_empty 
    Port ( rq2_wptr : in STD_LOGIC_VECTOR (4 downto 0);
           rinc : in STD_LOGIC;
           rclk : in STD_LOGIC;
           rrst : in STD_LOGIC;
           rempty : out STD_LOGIC;
           raddr : out STD_LOGIC_VECTOR (3 downto 0);
           rptr : out STD_LOGIC_VECTOR (4 downto 0));
end component;

component wraddress_full 
    Port ( wq2_rptr : in STD_LOGIC_VECTOR (4 downto 0);
           winc : in STD_LOGIC;
           wclk : in STD_LOGIC;
           wrst : in STD_LOGIC;
           wfull : out STD_LOGIC;
           waddr : out STD_LOGIC_VECTOR (3 downto 0);
           wptr : out STD_LOGIC_VECTOR (4 downto 0));
end component;

component sync_wr2rd 
    Port ( wptr : in STD_LOGIC_VECTOR (4 downto 0);
           rq2_wptr : out STD_LOGIC_VECTOR (4 downto 0);
           rclk : in STD_LOGIC;
           rrst : in STD_LOGIC);
end component;


component sync_rd2wr 
    Port ( rptr : in STD_LOGIC_VECTOR (4 downto 0);
           wq2_rptr : out STD_LOGIC_VECTOR (4 downto 0);
           wclk : in STD_LOGIC;
           wrst : in STD_LOGIC);
end component;
------------------------------------------------------------------------------------------------

signal rq2_wptr , wptr , rptr , wq2_rptr : STD_LOGIC_VECTOR (4 downto 0);
signal waddr , raddr  : STD_LOGIC_VECTOR (3 downto 0);
signal wclken , wfull_sig , rempty_sig : std_logic;

begin
wfull <= wfull_sig ;
 rempty <= rempty_sig ;
 wclken <= winc;
MEMORY_DPRAM: mem_fifo PORT MAP(wdata, waddr,raddr,wclk, rclk,wclken,wfull_sig,rdata) ;

WRITE_ADDRESS_FULL: wraddress_full   PORT MAP(wq2_rptr, winc,wclk,wrst, wfull_sig, waddr,wptr) ;

READ_ADDRESS_EMPTY: radrs_empty  PORT MAP(rq2_wptr, rinc,rclk,rrst, rempty_sig, raddr,rptr) ;

SYNCHRONIZER_READ_TO_WRITE: sync_rd2wr PORT MAP(rptr,wq2_rptr,wclk,wrst) ;

SYNCHRONIZER_WRITE_TO_READ:  sync_wr2rd  PORT MAP(wptr,rq2_wptr,rclk,rrst) ;






end Behavioral;
