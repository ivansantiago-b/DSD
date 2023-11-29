----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/29/2023 08:52:55 AM
-- Design Name: 
-- Module Name: pixel_clock_tb - Behavioral
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

entity pixel_clock_tb is
--  Port ( );
end pixel_clock_tb;

architecture Behavioral of pixel_clock_tb is
    signal sys_clk, clear, px_clk : std_logic;
begin
dut:
    entity work.pixel_clock port map(sys_clk => sys_clk, clear => clear, px_clk => px_clk);
sys_clk_stimulus:
    process
    begin
        sys_clk <= '0';
        wait for 5 ns;
        sys_clk <= '1';
        wait for 5 ns;
    end process sys_clk_stimulus;
stimulus:
    process
    begin
        clear <= '1';
        wait for 10 ns;
        clear <= '0';
        wait;
    end process stimulus;
end Behavioral;
