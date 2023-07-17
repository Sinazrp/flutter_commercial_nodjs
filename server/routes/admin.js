const express = require("express");
const admin = require("../middleware/admin");
const adminRouter = express.Router();
const { Product } = require('../model/product')
const Order = require("../model/order");

//
adminRouter.post('/admin/add-product', admin, async (req, res) => {
    try {
        const { name, description, images, quantity, price, category } = req.body
        let product = new Product({
            name,
            description,
            images,
            category,
            quantity,
            price
        });
        product = await product.save();
        res.json(product)

    } catch (error) {
        res.status(500).json({ error: error.message });

    }

});

adminRouter.get('/admin/get-products', admin, async (req, res) => {
    try {
        const products = await Product.find({});
        res.json(products);

    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

adminRouter.post('/admin/deleteproduct', admin, async (req, res) => {
    try {
        const { id } = req.body;
        const product = await Product.findByIdAndDelete(id);

        res.json(product)
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
})

// get all Orders
adminRouter.get('/admin/get-orders', admin, async (req, res) => {
    try {
        const orders = await Order.find({});
        res.json(orders);

    } catch (error) {
        res.status(500).json({ error: error.message });
    }

})

adminRouter.post('/admin/change-order-status', admin, async (req, res) => {
    try {
        const { id, status } = req.body;
        const order = await Order.findByIdAndUpdate(id, { status }, { new: true });
        res.json(order);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }

})

module.exports = adminRouter;