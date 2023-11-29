----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/28/2023 08:19:30 PM
-- Design Name: 
-- Module Name: vga_top - Behavioral
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

entity vga_top is
    port(
        system_clock, clear : in std_logic;
        sw : in std_logic_vector(15 downto 0);
        v_sync, h_sync : out std_logic;
        r, g, b : out std_logic_vector(3 downto 0)
    );
end vga_top;

architecture Behavioral of vga_top is
    component clk_wiz_0
    port (
        clk40 : out std_logic;
        reset : in std_logic;
        clk_in1 : in std_logic
     );
    end component;
    signal clk40 : std_logic;
    signal display_on : std_logic;
    signal x, y : std_logic_vector(9 downto 0);
    signal address : std_logic_vector(3 downto 0);
    signal row : std_logic_vector(30 downto 0);
begin
pll_pixel_clock:
    clk_wiz_0 port map (clk40 => clk40, reset => clear, clk_in1 => system_clock);
u0:
    entity work.vga_driver port map(pixel_clock => clk40, clear => clear, v_sync => v_sync, h_sync => h_sync, display_on => display_on, x => x, y => y);
u1:
    entity work.prom_initials port map(address => address, row => row);
u2:
    entity work.vga_initials port map(display_on => display_on, x => x, y => y, row => row, sw => sw, rom_address => address, r => r, g => g, b => b);
end Behavioral;
