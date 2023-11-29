----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/28/2023 10:44:53 PM
-- Design Name: 
-- Module Name: vga_initials - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

entity vga_initials is
    port(
        display_on : in std_logic;
        x, y : in std_logic_vector(9 downto 0);
        row : in std_logic_vector(30 downto 0);
        sw : in std_logic_vector(15 downto 0);
        rom_address : out std_logic_vector(3 downto 0);
        r, g, b : out std_logic_vector(3 downto 0)
    );
end vga_initials;

architecture Behavioral of vga_initials is
    constant w : integer := 31;
    constant h : integer := 15;
    signal ox, oy : std_logic_vector(9 downto 0);
    signal bm_row, bm_column : std_logic_vector(9 downto 0);
    signal show_sprite, pixel : std_logic;
begin
    ox <= "10" & sw(7 downto 0);
    oy <= "01" & sw(15 downto 8);
    bm_row <= std_logic_vector(unsigned(y) - unsigned(oy));
    rom_address <= bm_row(3 downto 0);
    bm_column <= std_logic_vector(unsigned(x) - unsigned(ox));
    show_sprite <= '1' when ((unsigned(x) >= unsigned(ox) and unsigned(x) < (unsigned(ox) + w)) and (unsigned(y) >= unsigned(oy) and unsigned(y) < (unsigned(oy) + h))) else '0';
    process(display_on, show_sprite, x, y)
        variable col : integer := 0;
    begin
        r <= (others => '0');
        g <= (others => '0');
        b <= (others => '0');
        if display_on = '1' then
            if show_sprite = '1' then
                col := to_integer(unsigned(bm_column(4 downto 0)));
                pixel <= row(col);
                r <= (others => pixel);
                g <= (others => pixel);
                b <= (others => pixel);
            else
                if (unsigned(x) > 66 and unsigned(x) <= 133) then
                    r(1 downto 0) <= "01";
                elsif (unsigned(x) > 133 and unsigned(x) <= 199) then
                    r(1 downto 0) <= "11";
                elsif (unsigned(x) > 199 and unsigned(x) <= 266) then
                    r(1 downto 0) <= "10";
                else
                    r(1 downto 0) <= "00";
                end if;
                
                if (unsigned(x) > 332 and unsigned(x) <= 399) then
                    g(1 downto 0) <= "01";
                elsif (unsigned(x) > 399 and unsigned(x) <= 465) then
                    g(1 downto 0) <= "11";
                elsif (unsigned(x) > 465 and unsigned(x) <= 532) then
                    g(1 downto 0) <= "10";
                else
                    g(1 downto 0) <= "00";
                end if;
                
                if (unsigned(x) > 598 and unsigned(x) <= 665) then
                    b(1 downto 0) <= "01";
                elsif (unsigned(x) > 665 and unsigned(x) <= 731) then
                    b(1 downto 0) <= "11";
                elsif (unsigned(x) > 731 and unsigned(x) <= 799) then
                    b(1 downto 0) <= "10";
                else
                    b(1 downto 0) <= "00";
                end if;
                
                if (unsigned(y) > 49 and unsigned(y) <= 99) then
                    r(3 downto 2) <= "01";
                elsif (unsigned(y) > 99 and unsigned(y) <= 149) then
                    r(3 downto 2) <= "11";
                elsif (unsigned(y) > 149 and unsigned(y) <= 199) then
                    r(3 downto 2) <= "10";
                else
                    r(3 downto 2) <= "00";
                end if;
                
                if (unsigned(y) > 249 and unsigned(y) <= 299) then
                    g(3 downto 2) <= "01";
                elsif (unsigned(y) > 299 and unsigned(y) <= 349) then
                    g(3 downto 2) <= "11";
                elsif (unsigned(y) > 349 and unsigned(y) <= 399) then
                    g(3 downto 2) <= "10";
                else
                    g(3 downto 2) <= "00";
                end if;
                
                if (unsigned(y) > 449 and unsigned(y) <= 499) then
                    b(3 downto 2) <= "01";
                elsif (unsigned(y) > 499 and unsigned(y) <= 549) then
                    b(3 downto 2) <= "11";
                elsif (unsigned(y) > 549 and unsigned(y) <= 599) then
                    b(3 downto 2) <= "10";
                else
                    b(3 downto 2) <= "00";
                end if;
            end if;
        end if;
    end process;
end Behavioral;
