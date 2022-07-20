const main = async () => {
    const [ owner, randomUser, another ] = await hre.ethers.getSigners();
    const ownerContractFactory = await hre.ethers.getContractFactory("WeaponFactory")
    const ownerContract = await ownerContractFactory.deploy()
    await ownerContract.deployed()

    console.log("ownership Contract address is :", ownerContract.address);

    let txn = await ownerContract.createCharacter("Lawwee", 0);
    await txn.wait();
    console.log("Address of owner is:", owner.address);

    txn = await ownerContract.blessing()
    await txn.wait()

    txn = await ownerContract.firstQuest("Lawwee");
    await txn.wait();

    txn = await ownerContract.myWeapons("Lawwee");

}

const runMain = async () => {
    try {
        await main()
        process.exit(0)
    } catch (error) {
        console.log(error);
        process.exit(1)
    }
}

runMain();