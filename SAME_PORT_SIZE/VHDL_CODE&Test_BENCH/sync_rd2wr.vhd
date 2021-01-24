----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/21/2020 10:54:25 AM
-- Design Name: 
-- Module Name: sync_rd2wr - Behavioral
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

entity sync_rd2wr is
    Port ( rptr : in STD_LOGIC_VECTOR (4 downto 0);
           wq2_rptr : out STD_LOGIC_VECTOR (4 downto 0);
           wclk : in STD_LOGIC;
           wrst : in STD_LOGIC);
end sync_rd2wr;

architecture Behavioral of sync_rd2wr is
signal wq1_rptr : STD_LOGIC_VECTOR (4 downto 0);
begin

process(wclk,wrst)
begin
if(wrst'event and wrst='0')
then
wq2_rptr <= (others=>'0') ;
wq1_rptr <= (others=>'0') ;
end if ;
if(wclk'event and wclk='1' and wrst='1')
then
wq1_rptr <= rptr ;
wq2_rptr  <= wq1_rptr ;
end if ;


end process;


end Behavioral;
