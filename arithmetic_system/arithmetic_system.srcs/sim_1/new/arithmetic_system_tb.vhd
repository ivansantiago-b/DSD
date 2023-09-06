----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/26/2023 02:21:09 PM
-- Design Name: 
-- Module Name: arithmetic_system_tb - Behavioral
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

entity arithmetic_system_tb is
--  Port ( );
end arithmetic_system_tb;

architecture Behavioral of arithmetic_system_tb is
    signal clk : std_logic := '0';
    signal a, b : std_logic_vector (3 downto 0);
    signal sel : std_logic_vector (1 downto 0);
    signal cathodes : std_logic_vector (6 downto 0);
    signal anodes : std_logic_vector (3 downto 0);
begin
dut:
    entity work.arithmetic_system port map(clk => clk, a => a, b => b, sel => sel, cathodes => cathodes, anodes => anodes);
stimulus:
    clk <= '0' after 5 ns when clk = '1' else
           '1' after 5 ns when clk = '0';
    process
    begin
        sel <= "00";
        a <= "1010";
        b <= "0101";
        wait for 20 ms;
        sel <= "01";
        wait for 20 ms;
        sel <= "10";
        wait for 20 ms;
        sel <= "11";
        wait for 20 ms;
        sel <= "00";
        a <= "1111";
        b <= "1111";
        wait for 20 ms;
        sel <= "01";
        wait for 20 ms;
        sel <= "10";
        wait for 20 ms;
        sel <= "11";
        wait for 20 ms;
        sel <= "00";
        a <= "0011";
        b <= "1111";
        wait for 20 ms;
        sel <= "01";
        wait for 20 ms;
        sel <= "10";
        wait for 20 ms;
        sel <= "11";
        wait;
    end process;
end Behavioral;
