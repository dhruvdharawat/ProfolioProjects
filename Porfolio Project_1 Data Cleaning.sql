---------------------Cleaning Data In SQL Queries-------------------------

select * 
from NashvilleHousing


--Standarsied Date Format
select Saledateconverted, convert(date,SaleDate)
from NashvilleHousing

alter table NashvilleHousing
add Saledateconverted date

Update NashvilleHousing
Set Saledateconverted=convert(date,SaleDate)




--Populate Property Address

select *
from NashvilleHousing
--where propertyAddress is null
order by ParcelID

select a.ParcelID,a.PropertyAddress,b.ParcelID,b.PropertyAddress ,ISNULL(a.PropertyAddress,b.PropertyAddress)
from NashvilleHousing a
join NashvilleHousing b
on a.ParcelID=b.ParcelID
and a.[UniqueID ]<>b.[UniqueID ]
where a.PropertyAddress is null

update a
set PropertyAddress=ISNULL(a.PropertyAddress,b.PropertyAddress)
from NashvilleHousing a
join NashvilleHousing b
on a.ParcelID=b.ParcelID
and a.[UniqueID ]<>b.[UniqueID ]




--Breaking out the Address Column

select PropertyAddress
from NashvilleHousing

select 
substring (PropertyAddress,1,CHARINDEX(',',PropertyAddress)-1) as Address
,substring (PropertyAddress,CHARINDEX(',',PropertyAddress)+1,len(PropertyAddress)) as Address
from 
NashvilleHousing


alter table NashvilleHousing
add PropertySplitAddress nvarchar(200);

update NashvilleHousing
set PropertySplitAddress = substring (PropertyAddress,1,CHARINDEX(',',PropertyAddress)-1) 

alter table NashvilleHousing
add Propertysplitcity nvarchar(200);

update NashvilleHousing
set Propertysplitcity=substring (PropertyAddress,CHARINDEX(',',PropertyAddress)+1,len(PropertyAddress))

select * 
from NashvilleHousing


select 
parsename(replace(OwnerAddress,',','.'),3)
,parsename(replace(OwnerAddress,',','.'),2)
,parsename(replace(OwnerAddress,',','.'),1)
from NashvilleHousing

alter table NashvilleHousing
add Ownersplitaddress nvarchar(200);

update NashvilleHousing
set Ownersplitaddress = parsename(replace(OwnerAddress,',','.'),3)

alter table NashvilleHousing
add Ownersplitcity nvarchar(200);

update NashvilleHousing
set Ownersplitcity=parsename(replace(OwnerAddress,',','.'),2)

alter table NashvilleHousing
add Ownersplitstate nvarchar(200);

update NashvilleHousing
set Ownersplitstate=parsename(replace(OwnerAddress,',','.'),1)

select * 
from NashvilleHousing



--Change Y and N to YES and NO in 'Sold as Vacant' field

select distinct(SoldAsVacant)
from NashvilleHousing

select SoldAsVacant,
case
when SoldAsVacant = 'Y' then 'YES'
when SoldAsVacant = 'N' then 'NO'
else SoldAsVacant
end
from NashvilleHousing

update NashvilleHousing
set SoldAsVacant = case
when SoldAsVacant = 'Y' then 'YES'
when SoldAsVacant = 'N' then 'NO'
else SoldAsVacant
end

select distinct(SoldAsVacant)
from NashvilleHousing



--Delete Unused Columns

select * 
from NashvilleHousing

Alter table NashvilleHousing
Drop column OwnerAddress,TaxDistrict,PropertyAddress

Alter table NashvilleHousing
Drop column SaleDate

select *
from NashvilleHousing

