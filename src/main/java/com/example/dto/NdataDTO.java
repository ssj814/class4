package com.example.dto;

import org.apache.ibatis.type.Alias;

@Alias("NdataDTO")
public class NdataDTO {
	private int id;
    private float energy;     // 에너지 (kcal)
    private float carbs;      // 탄수화물 (g)
    private float sugar;      // 당류 (g)
    private float protein;    // 단백질 (g)
    private float fat;        // 지방 (g)
    private float sat_Fat;     // 포화지방 (g)
    private float sodium;     // 나트륨 (mg)
	public NdataDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public NdataDTO(int id, float energy, float carbs, float sugar, float protein, float fat, float satFat,
			float sodium) {
		super();
		this.id = id;
		this.energy = energy;
		this.carbs = carbs;
		this.sugar = sugar;
		this.protein = protein;
		this.fat = fat;
		this.sat_Fat = satFat;
		this.sodium = sodium;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public float getEnergy() {
		return energy;
	}
	public void setEnergy(float energy) {
		this.energy = energy;
	}
	public float getCarbs() {
		return carbs;
	}
	public void setCarbs(float carbs) {
		this.carbs = carbs;
	}
	public float getSugar() {
		return sugar;
	}
	public void setSugar(float sugar) {
		this.sugar = sugar;
	}
	public float getProtein() {
		return protein;
	}
	public void setProtein(float protein) {
		this.protein = protein;
	}
	public float getFat() {
		return fat;
	}
	public void setFat(float fat) {
		this.fat = fat;
	}
	public float getSatFat() {
		return sat_Fat;
	}
	public void setSatFat(float satFat) {
		this.sat_Fat = satFat;
	}
	public float getSodium() {
		return sodium;
	}
	public void setSodium(float sodium) {
		this.sodium = sodium;
	}
	@Override
	public String toString() {
		return "NdataDTO [id=" + id + ", energy=" + energy + ", carbs=" + carbs + ", sugar=" + sugar + ", protein="
				+ protein + ", fat=" + fat + ", satFat=" + sat_Fat + ", sodium=" + sodium + "]";
	}

    
    
}
