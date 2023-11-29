----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/29/2023 12:04:40 AM
-- Design Name: 
-- Module Name: vga_top_tb - Behavioral
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

entity vga_top_tb is
--  Port ( );
end vga_top_tb;

architecture Behavioral of vga_top_tb is
    signal system_clock, clear, v_sync, h_sync : std_logic;
    signal sw : std_logic_vector(15 downto 0);
    signal r, g, b : std_logic_vector(3 downto 0);
begin
dut:
    entity work.vga_top port map(system_clock => system_clock, clear => clear, sw => sw, v_sync => v_sync, h_sync => h_sync, r => r, g => g, b => b);
clock_stimulus:
    process
    begin
        system_clock <= '0';
        wait for 5 ns;
        system_clock <= '1';
        wait for 5 ns;
    end process clock_stimulus;
stimulus:
    process
    begin
        clear <= '1';
        wait for 5 ns;
        clear <= '0';
        sw <= x"0000";
        wait;
    end process stimulus;
end Behavioral;
