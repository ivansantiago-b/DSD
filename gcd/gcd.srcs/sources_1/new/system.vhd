----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/13/2023 03:29:52 PM
-- Design Name: 
-- Module Name: system - Behavioral
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

entity system is
    port(
        x_in, y_in : in std_logic_vector(3 downto 0);
        master_clock, reset : in std_logic;
        buttons : in std_logic_vector(3 downto 0);
        anodes : out std_logic_vector(3 downto 0);
        cathodes : out std_logic_vector(6 downto 0);
        done : out std_logic
    );
end system;

architecture Behavioral of system is
    signal debounced_buttons : std_logic_vector(3 downto 0);
    signal clock_190Hz, clock_25MHz, clock_pulse: std_logic;
    signal gcd : std_logic_vector(3 downto 0);
    signal x_gcd : std_logic_vector(15 downto 0);
begin
    x_gcd <= "000000000000" & gcd;
    U0:
    entity work.frequency_divider generic map(prescaler => 19) port map(master_clock => master_clock, reset => reset, slow_clock => clock_190Hz);
    U1:
    entity work.frequency_divider generic map(prescaler => 2) port map(master_clock => master_clock, reset => reset, slow_clock => clock_25MHz);
    U2:
    entity work.debounce generic map(n => 4) port map(clock => clock_190Hz, reset => reset, input => buttons, output => debounced_buttons);
    U3:
    entity work.clock_pulse port map(clock => clock_25MHz, reset => reset, input => debounced_buttons(0), pulse => clock_pulse);
    U4:
    entity work.euclidean_algorithm generic map(n => 4) port map(clock => clock_25MHz, clear => reset,  go => clock_pulse, x_in => x_in, y_in => y_in, gcd => gcd, done => done);
    U5:
    entity work.X7segb port map(x => x_gcd, cclk => clock_190Hz, clr => reset, a_to_g => cathodes, an => anodes);
end Behavioral;
