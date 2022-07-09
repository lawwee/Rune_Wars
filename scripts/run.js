const main = async () => {
    const [ owner, randomUser, another ] = await hre.ethers.getSigners();
    const ownerContractFactory = await hre.ethers.getContractFactory("RuneAttack")
    const ownerContract = await ownerContractFactory.deploy()
    await ownerContract.deployed()

    console.log("ownership Contract address is :", ownerContract.address);

    // let txn = await ownerContract._npcCharacter("Blessing", 9867);
    // await txn.wait()

    // let txn = await ownerContract.createNPC(0);
    // await txn.wait()

    let txn = await ownerContract.createCharacter("Lawwee", 1);
    await txn.wait();
    console.log("Address of owner is:", owner.address);

    // txn = await ownerContract.chooseClan(1);

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