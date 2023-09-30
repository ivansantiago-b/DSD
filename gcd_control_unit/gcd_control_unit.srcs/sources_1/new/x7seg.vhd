----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/30/2023 12:39:43 PM
-- Design Name: 
-- Module Name: x7seg - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity x7seg is
    port(
        clock, reset : in std_logic;
        x : in std_logic_vector(15 downto 0);
        anodes : out std_logic_vector(3 downto 0);
        cathodes : out std_logic_vector(6 downto 0)
    );   
end x7seg;

architecture Behavioral of x7seg is
    signal digit : std_logic_vector (3 downto 0);
    signal count : std_logic_vector (1 downto 0);
    signal enable : std_logic_vector (3 downto 0);
begin

    enable(3) <= x(15) or x(14) or x(13) or x(12);
    enable(2) <= x(15) or x(14) or x(13) or x(12) or x(11) or x(10) or x(9) or x(8);
    enable(1) <= x(15) or x(14) or x(13) or x(12) or x(11) or x(10) or x(9) or x(8) or x(7) or x(6) or x(5) or x(4);
    enable(0) <= '1';
    
    process (clock, reset)
    begin
        if reset = '1' then
            count <= "00";
        elsif rising_edge(clock) then
            count <= count + 1;
        end if;
    end process;
    
    with count select
        digit <= x(3 downto 0) when "00",
                 x(7 downto 4) when "01",
                 x(11 downto 8) when "10",
                 x(15 downto 12) when others;
    with digit select
        cathodes <= "1001111" when "0001", --1
                    "0010010" when "0010", --2
                    "0000110" when "0011", --3
                    "1001100" when "0100", --4
                    "0100100" when "0101", --5
                    "0100000" when "0110", --6
                    "0001111" when "0111", --7
                    "0000000" when "1000", --8
                    "0000100" when "1001", --9
                    "0001000" when "1010", --A
                    "1100000" when "1011", --B
                    "0110001" when "1100", --C
                    "1000010" when "1101", --D
                    "0110000" when "1110", --E
                    "0111000" when "1111", --F
                    "0000001" when others; --0
                  
    process(count, enable)
    begin
        if enable(conv_integer(count)) = '1' then
            anodes <= (others => '1');
            anodes(conv_integer(count)) <= '0';
        else
            anodes <= "1111";
        end if;
    end process;
end Behavioral;
