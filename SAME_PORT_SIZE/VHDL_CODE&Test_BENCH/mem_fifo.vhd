----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/22/2020 05:03:28 AM
-- Design Name: 
-- Module Name: mem_fifo - Behavioral
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

entity mem_fifo is
    Port ( wdata : in STD_LOGIC_VECTOR (7 downto 0);
           waddr : in STD_LOGIC_VECTOR (3 downto 0);
           raddr : in STD_LOGIC_VECTOR (3 downto 0);
           wclk : in STD_LOGIC;
           rclk : in STD_LOGIC;
           wclken : in STD_LOGIC;
           wfull : in STD_LOGIC;
           rdata : out STD_LOGIC_VECTOR (7 downto 0));
end mem_fifo;

architecture Behavioral of mem_fifo is

COMPONENT blk_mem_gen_0
  PORT (
    clka : IN STD_LOGIC;
    ena : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    clkb : IN STD_LOGIC;
    addrb : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    doutb : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
END COMPONENT;
signal  write_enble : STD_LOGIC_VECTOR (0 downto 0);
signal  wr_clk_en : STD_LOGIC;
begin
wr_clk_en <= wclken and not(wfull);
write_enble <= "1" ;

MEMORY_DPRAM : blk_mem_gen_0
  PORT MAP (
    clka => wclk,
    ena => wr_clk_en,
    wea => write_enble,
    addra => waddr,
    dina => wdata,
    clkb => rclk,
    addrb => raddr,
    doutb => rdata
  );
  

--


end Behavioral;
