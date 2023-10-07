----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/06/2023 11:02:38 AM
-- Design Name: 
-- Module Name: divider_tb - Behavioral
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

entity divider_tb is
--  Port ( );
end divider_tb;

architecture Behavioral of divider_tb is
    signal clock, reset, go : std_logic;
    signal x, y, d, m: std_logic_vector(15 downto 0);
begin
dut:
    entity work.divider_top port map(clock => clock, reset => reset, go => go, x => x, y => y, d => d, m => m);
stimulus:
    process
    begin
        clock <= '0';
        wait for 5 ns;
        clock <= '1';
        wait for 5 ns;
    end process;
    
    process
    begin
        reset <= '1';
        x <= x"0001";
        y <= x"FFFF";
        wait for 10 ns;
        reset <= '0';
        go <= '1';
        wait for 10 ns;
        go <= '0';
        wait;
    end process;
end Behavioral;
