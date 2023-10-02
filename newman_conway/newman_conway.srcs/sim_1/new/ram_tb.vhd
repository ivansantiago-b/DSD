----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/01/2023 11:35:02 PM
-- Design Name: 
-- Module Name: ram_tb - Behavioral
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

entity ram_tb is
--  Port ( );
end ram_tb;

architecture Behavioral of ram_tb is
    signal address : std_logic_vector(7 downto 0);
    signal data_in, data_out : std_logic_vector(6 downto 0);
    signal we: std_logic;
begin
dut:
    entity work.ram port map(we => we, data_in => data_in, data_out => data_out, address => address);
stimulus:
    process
    begin
        address <= x"00";
        data_in <= "1010011";
        we <= '1';
        wait for 10 ns;
        we <= '0';
        wait for 10 ns;
        address <= x"FF";
        data_in <= "1010101";
        wait for 10 ns;
        we <= '1';
        wait for 10 ns;
        we <= '0';
        wait for 10 ns;
        address <= x"01";
        wait for 10 ns;
        address <= x"02";
        wait for 10 ns;
    end process;
end Behavioral;
