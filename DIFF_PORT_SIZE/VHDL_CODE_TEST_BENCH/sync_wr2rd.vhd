----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/21/2020 11:37:16 AM
-- Design Name: 
-- Module Name: sync_wr2rd - Behavioral
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

Library UNISIM;
use UNISIM.vcomponents.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sync_wr2rd is
    Port ( wptr : in STD_LOGIC_VECTOR (4 downto 0);
           rq2_wptr : out STD_LOGIC_VECTOR (4 downto 0);
           rclk : in STD_LOGIC;
           rrst : in STD_LOGIC);
end sync_wr2rd;

architecture Behavioral of sync_wr2rd is
signal rq1_wptr , wptr_str  : STD_LOGIC_VECTOR (4 downto 0);
begin
--BUFG_inst2 : BUFG
--   port map (
--      O => rrst_buff, -- 1-bit output: Clock output
--      I => rrst  -- 1-bit input: Clock input
--   );

process(rclk,rrst)
begin
if(rrst'event and rrst='0')
then
rq2_wptr <= (others=>'0') ;
rq1_wptr <= (others=>'0') ;
end if ;
if(rclk'event and rclk='1' and rrst='1')
then

rq1_wptr <= wptr ;
rq2_wptr  <= rq1_wptr ;

end if ;


end process;


end Behavioral;
