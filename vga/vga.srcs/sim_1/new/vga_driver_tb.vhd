----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/28/2023 06:41:52 PM
-- Design Name: 
-- Module Name: vga_driver_tb - Behavioral
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

entity vga_driver_tb is
--  Port ( );
end vga_driver_tb;

architecture Behavioral of vga_driver_tb is
    signal pixel_clock, clear, v_sync, h_sync, display_on : std_logic;
    signal x, y : std_logic_vector(9 downto 0);
begin
dut:
    entity work.vga_driver port map(pixel_clock => pixel_clock, clear => clear, v_sync => v_sync, h_sync => h_sync, display_on => display_on, x => x, y => y);
clk_stimulus:
    process
    begin
        pixel_clock <= '0';
        wait for 12.5 ns;
        pixel_clock <= '1';
        wait for 12.5 ns;
    end process clk_stimulus;
stimulus:
    process
    begin
        clear <= '1';
        wait for 25 ns;
        clear <= '0';
        wait;
    end process stimulus;
end Behavioral;
