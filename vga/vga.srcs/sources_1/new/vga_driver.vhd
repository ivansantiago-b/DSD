----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/28/2023 04:17:39 PM
-- Design Name: 
-- Module Name: vga_driver - Behavioral
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

entity vga_driver is
    port(
        pixel_clock, clear : in std_logic;
        v_sync, h_sync, display_on : out std_logic;
        x, y : out std_logic_vector(9 downto 0)
    );
end vga_driver;

architecture Behavioral of vga_driver is
    -- 800x600 @60 Hz
    -- Horizontal timmings
    constant hac : integer := 800;  -- Active
    constant hsw : integer := 128;  -- Sync width
    constant hbp : integer := 88;   -- Back porch
    constant hfp : integer := 40;   -- Front porch
    constant htp : integer := 1056; -- Total pixels
    constant h1 : integer := hsw + hbp;
    constant h2 : integer := h1 + hac;
    -- Vertical timmings
    constant vac : integer := 600;  -- Active
    constant vsw : integer := 4;    -- Sync width
    constant vfp : integer := 1;    -- Front porch
    constant vbp : integer := 23;   -- Back porch
    constant vtl : integer := 628;  -- Total lines
    constant v1 : integer := vsw + vbp;
    constant v2 : integer := v1 + vac;
    -- Signals
    signal hcounter : integer range 1 to htp;
    signal vcounter : integer range 1 to vtl;
    signal venable : std_logic;
    signal xcounter : unsigned(9 downto 0);
    signal ycounter : unsigned(9 downto 0);
begin
hsync:
    process(pixel_clock, clear)
    begin
        if clear = '1' then
            hcounter <= 1;
            xcounter <= (others => '0');
            venable <= '0';
        elsif rising_edge(pixel_clock) then
            if hcounter = htp then
                hcounter <= 1;
                venable <= '1';
            else
                hcounter <= hcounter + 1;
                venable <= '0';
            end if;
            if (hcounter > h1 and hcounter < h2) then
                xcounter <= xcounter + 1;
            else
                xcounter <= (others => '0');
            end if;
        end if;
    end process hsync;
    h_sync <= '0' when hcounter <= hsw else '1';
    x <= std_logic_vector(xcounter);
vsync:
    process(pixel_clock, clear, venable)
    begin
        if clear = '1' then
            vcounter <= 1;
            ycounter <= (others => '0');
        elsif (rising_edge(pixel_clock) and venable = '1') then
            if vcounter = vtl then
                vcounter <= 1;
            else
                vcounter <= vcounter + 1;
            end if;
            if (vcounter > v1 and vcounter < v2) then
                ycounter <= ycounter + 1;
            else
                ycounter <= (others => '0');
            end if; 
        end if;
    end process vsync;
    v_sync <= '0' when vcounter <= vsw else '1';
    y <= std_logic_vector(ycounter);
    display_on <= '1' when ((hcounter > h1 and hcounter <= h2) and (vcounter > v1 and vcounter <= v2)) else '0';
end Behavioral;
