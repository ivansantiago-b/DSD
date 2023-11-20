----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/19/2023 06:17:48 PM
-- Design Name: 
-- Module Name: mux7seg - Behavioral
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

entity mux7seg is
    port(
        clock, clear : in std_logic;
        bcd : in std_logic_vector(15 downto 0);
        anodes : out std_logic_vector(3 downto 0);
        cathodes : out std_logic_vector(6 downto 0)
    );
end mux7seg;

architecture Behavioral of mux7seg is
    signal counter : std_logic_vector(1 downto 0);
    signal enable, digit : std_logic_vector(3 downto 0);
    
begin
    enable(3) <= bcd(15) or bcd(14) or bcd(13) or bcd(12);
    enable(2) <= enable(3) or bcd(11) or bcd(10) or bcd(9) or bcd(8);
    enable(1) <= enable(3) or enable(2) or bcd(7) or bcd(6) or bcd(5) or bcd(4);
    enable(0) <= '1';
    
    process(clock, clear)
    begin
        if clear = '1' then
            counter <= "00";
        elsif rising_edge(clock) then
            counter <= counter + 1;
        end if;
    end process;
    
    with counter select
        digit <= bcd(3 downto 0) when "00",
                 bcd(7 downto 4) when "01",
                 bcd(11 downto 8) when "10",
                 bcd(15 downto 12) when others;
        
    with digit select
        cathodes <= "1000000" when "0000", -- 0
                    "1111001" when "0001", -- 1
                    "0100100" when "0010", -- 2
                    "0110000" when "0011", -- 3
                    "0011001" when "0100", -- 4
                    "0010010" when "0101", -- 5
                    "0000010" when "0110", -- 6
                    "1111000" when "0111", -- 7
                    "0000000" when "1000", -- 8
                    "0010000" when "1001", -- 9
                    "1111111" when others; -- OFF
                    
    process(counter, enable)
    begin
        if enable(conv_integer(counter)) = '1' then
            anodes <= (others => '1');
            anodes(conv_integer(counter)) <= '0';
        else
            anodes <= "1111";
        end if;
    end process;
end Behavioral;
