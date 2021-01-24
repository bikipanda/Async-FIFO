----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/21/2020 11:10:49 AM
-- Design Name: 
-- Module Name: tb_sync_rd2wr - Behavioral
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

entity tb_sync_rd2wr is
--  Port ( );
end tb_sync_rd2wr;

architecture Behavioral of tb_sync_rd2wr is
component fifo_top_module
    Port ( wdata : in STD_LOGIC_VECTOR (7 downto 0);
           winc : in STD_LOGIC;
           wclk : in STD_LOGIC;
           rclk : in STD_LOGIC;
           wrst : in STD_LOGIC;
           rrst : in STD_LOGIC;
           rinc : in STD_LOGIC;
           rdata : out STD_LOGIC_VECTOR (3 downto 0);
           wfull : out STD_LOGIC;
           rempty : out STD_LOGIC);
end component;
signal  wdata  : STD_LOGIC_VECTOR (7 downto 0);
signal   rdata : STD_LOGIC_VECTOR (3 downto 0);
signal rclk,wclk,winc,rinc,wrst,rrst ,wfull,rempty:std_logic;
constant wr_period: time:= 20 ns;
constant rd_period: time:= 40 ns;

begin
DUT: fifo_top_module   PORT MAP(wdata,winc,wclk,rclk,  wrst,rrst, rinc,rdata, wfull,rempty) ;


wr_clock:process
begin
wait for 100ns;
loop_wr: loop
wclk<='0';
wait for wr_period/2;
wclk<='1';
wait for wr_period/2;
end loop;
end process;

rd_clock:process
begin
wait for 100ns;
loop_rd: loop
rclk<='0';
wait for rd_period/2;
rclk<='1';
wait for rd_period/2;
end loop;
end process;


process
begin
wait for 100ns;

-- Enable the reset
wrst<='0';
rrst<='0';

-- Disable the write and read to FIFO
rinc <= '0' ;
winc <= '0' ;

wait for 40ns;

-- remove the reset signals
wrst<='1';
rrst<='1';

wait for 20ns;

-- Demonstrating that data cannot be given until winc(matlab write enable) = 1;
wdata <=X"01" ;
wait for 5*wr_period;
-- Observe that the write addr counter doesn't increment for the entire 5 wr_period.

--now enabled the writing to FIFO;(NOTE: before enabling winc initiate the data to be written else 0 will be written)
--Here we have initiated 01 previously,which earlier the FIFO didn't took but now it will take since we are making winc = 1 now
--We will write 5 data to fifo, ALL THE WHILE KEEPING READ DISABLED, we should see the write addr counter at 4//5 and the read_Counter still at 0;
winc <= '1';
wait for wr_period;
wdata <=X"f5" ;
wait for wr_period;
wdata <=X"0A" ;
wait for wr_period;
wdata <=X"0F" ;
wait for wr_period;
wdata <=X"14" ;
wait for wr_period;
winc <= '0';
wait for 2*rd_period;
rinc <= '1';
wait for 10*rd_period;
rinc <= '0';
wait for 10*rd_period;

--testing the full flag
wdata <=X"01" ;
wait for 2*wr_period;
winc <= '1';
wait for wr_period;
wdata <=X"f2" ;
wait for wr_period;
wdata <=X"e3" ;
wait for wr_period;
wdata <=X"a4" ;
wait for wr_period;
wdata <=X"b5" ;
wait for wr_period;
wdata <=X"06" ;
wait for wr_period;
wdata <=X"07" ;
wait for wr_period;
wdata <=X"08" ;
wait for wr_period;
wdata <=X"09" ;
wait for wr_period;
wdata <=X"0A" ;
wait for wr_period;
wdata <=X"0B" ;
wait for wr_period;
wdata <=X"0C" ;
wait for wr_period;
wdata <=X"0D" ;
wait for wr_period;
wdata <=X"0E" ;
wait for wr_period;
wdata <=X"0F" ;
wait for wr_period;
wdata <=X"10" ;
-- Now that the fifo is full the next two data should not be registered into the fifo.
wait for wr_period;
wdata <=X"11" ;
wait for wr_period;
wdata <=X"12" ;
wait for wr_period;
winc <= '0';
wait for rd_period;
rinc <= '1';
wait for 35*rd_period;
rinc <= '0';
wait;
end process;


end Behavioral;
