----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/21/2020 07:18:00 PM
-- Design Name: 
-- Module Name: wraddress_full - Behavioral
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
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity wraddress_full is
    Port ( wq2_rptr : in STD_LOGIC_VECTOR (4 downto 0);
           winc : in STD_LOGIC;
           wclk : in STD_LOGIC;
           wrst : in STD_LOGIC;
           wfull : out STD_LOGIC;
           waddr : out STD_LOGIC_VECTOR (3 downto 0);
           wptr : out STD_LOGIC_VECTOR (4 downto 0));
end wraddress_full;

architecture Behavioral of wraddress_full is
signal wbinary , wbinary_next , wgray_next : STD_LOGIC_VECTOR (4 downto 0);
signal  wfull_sync , wfull_value :  STD_LOGIC;
begin

wfull <=  wfull_sync ;
waddr <= wbinary(3 downto 0) ;

wbinary_next <= wbinary + (winc and not(wfull_sync));
wgray_next <= wbinary_next xor ('0' & wbinary_next(4 downto 1)) ;

wfull_value <= '1' when ((wq2_rptr(4)=not(wgray_next(4))) and (wq2_rptr(3)=not(wgray_next(3))) and (wq2_rptr(2 downto 0)= wgray_next(2 downto 0))  ) else
                '0' ;



process(wclk,wrst)
begin
if(wrst'event and wrst='0')
then
wbinary <= (others=>'0') ;
wptr <= (others=>'0') ;
end if;

if(wclk'event and wclk='1' and wrst='1')
then

wbinary <= wbinary_next ;
wptr  <= wgray_next ;

end if ;

end process;


process(wclk,wrst)
begin
if(wrst'event and wrst='0')
then
wfull_sync <= '0' ;

end if ;

if(wclk'event and wclk='1' and wrst='1')
then
wfull_sync <= wfull_value ;
end if ;

end process;



end Behavioral;
