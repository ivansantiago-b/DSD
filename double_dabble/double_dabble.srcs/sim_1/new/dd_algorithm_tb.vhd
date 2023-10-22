----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/22/2023 01:24:29 AM
-- Design Name: 
-- Module Name: dd_algorithm_tb - Behavioral
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

entity dd_algorithm_tb is
--  Port ( );
end dd_algorithm_tb;

architecture Behavioral of dd_algorithm_tb is
    signal clock, clear, go : std_logic;
    signal n : std_logic_vector(7 downto 0);
    signal bcd : std_logic_vector(11 downto 0);
begin
dut:
    entity work.dd_algorithm port map(clock => clock, clear => clear, go => go, n => n, bcd => bcd);
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
        clear <= '1';
        go <= '0';
        n <= x"FF";
        wait for 10 ns;
        clear <= '0';
        go <= '1';
        wait for 180 ns;
        go <= '0';
        clear <= '1';
        wait for 10 ns;
        clear <= '0';
        go <= '1';
        n <= x"AF";
        wait for 180 ns;
        go <= '0';
        clear <= '1';
        wait for 10 ns;
        clear <= '0';
        go <= '1';
        n <= x"01";
        wait for 180 ns;
        go <= '0';
        clear <= '1';
        wait for 10 ns;
        clear <= '0';
        go <= '1';
        n <= x"0A";
        wait for 180 ns;
        go <= '0';
        clear <= '1';
        wait for 10 ns;
        go <= '1';
        clear <= '0';
        n <= x"3E";
        wait;
    end process;
end Behavioral;
