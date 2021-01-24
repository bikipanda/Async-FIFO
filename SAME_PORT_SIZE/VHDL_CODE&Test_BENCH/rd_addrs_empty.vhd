----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/21/2020 05:20:32 PM
-- Design Name: 
-- Module Name: radrs_empty - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

Library UNISIM;
use UNISIM.vcomponents.all;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity radrs_empty is
    Port ( rq2_wptr : in STD_LOGIC_VECTOR (4 downto 0);
           rinc : in STD_LOGIC;
           rclk : in STD_LOGIC;
           rrst : in STD_LOGIC;
           rempty : out STD_LOGIC;
           raddr : out STD_LOGIC_VECTOR (3 downto 0);
           rptr : out STD_LOGIC_VECTOR (4 downto 0));
end radrs_empty;

architecture Behavioral of radrs_empty is
signal rbinary , rbinary_next , rgray_next : STD_LOGIC_VECTOR (4 downto 0);
signal  rempt_sync , rempt_value  :  STD_LOGIC;
begin


--BUFG_inst1 : BUFG
--   port map (
--      O => rinc_buff, -- 1-bit output: Clock output
--      I => rinc  -- 1-bit input: Clock input
--   );
--BUFG_inst2 : BUFG
--   port map (
--      O => rrst_buff, -- 1-bit output: Clock output
--      I => rrst  -- 1-bit input: Clock input
--   );

 rempty <=  rempt_sync ;
 raddr <= rbinary(3 downto 0) ;
rbinary_next <= rbinary + (rinc and not(rempt_sync));

rgray_next <= rbinary_next xor ('0' & rbinary_next(4 downto 1)) ;

rempt_value <= '1' when (rgray_next = rq2_wptr) else
                '0'  ;
process(rclk,rrst)
begin
if(rrst'event and rrst='0')
then
rbinary <= (others=>'0') ;
rptr <= (others=>'0') ;

end if ;
if(rclk'event and rclk='1' and rrst='1')
then

rbinary <= rbinary_next ;
rptr  <= rgray_next ;

end if ;

end process;



process(rclk,rrst)
begin
if(rrst'event and rrst='0')
then
rempt_sync <= '0' ;
end if ;

if(rclk'event and rclk='1' and rrst='1')
then
rempt_sync <= rempt_value ;
end if ;

end process;


end Behavioral;
