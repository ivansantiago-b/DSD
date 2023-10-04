----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/03/2023 09:14:18 PM
-- Design Name: 
-- Module Name: register_tb - Behavioral
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

entity register_tb is
--  Port ( );
end register_tb;

architecture Behavioral of register_tb is
    signal clock : std_logic := '0';
    signal reset, we : std_logic;
    signal data_in, data_out : std_logic_vector(7 downto 0);
begin
dut:
    entity work.register_8bit port map(clock => clock, reset => reset, we => we, data_in => data_in, data_out => data_out);
stimulus:
    process
    begin
        reset <= '1';
        wait for 10 ns;
        reset <= '0';
        data_in <= x"FF";
        we <= '1';
        wait for 10 ns;
        we <= '0';
        data_in <= x"A0";
        we <= '1';
        wait for 10 ns;
        we <= '0';
        we <= '0';
        data_in <= x"3D";
        we <= '1';
        wait for 10 ns;
        we <= '0';
        wait;
    end process;
    clock <= not clock after 5 ns;
end Behavioral;
